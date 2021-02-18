
head.out<- function(msg){
  msg.out(msg, TRUE)
}


msg.out<- function(msg,head=FALSE) 
{
  cat("\n")
  if (head){ 
    cat ("\n-----------------------------------\n") 
  }else{ cat (" > ")}
  cat (msg)
  #if (head){ cat ("\n")}  

}



library(data.table)

head.out("CFHA LOAD ANALYSIS - Dec 07")

head.out("Reading Data:")
msg.out("Loading asset info from CFHA-IDs.csv -> DataAssetsByID")
DataAssetsByID <- read.csv("Archetype-SCs.csv")


msg.out("Loading run Data from CFHA-RunData.csv -> DataRuns ")
DataRuns <- read.csv("CFHA-RunData.csv")


msg.out("COLUMNS: DataRuns")
colnames(DataRuns)


msg.out("COLUMNS: DataAssetsByID")
colnames(DataAssetsByID)

head.out("Merging DataAssetsByID <-> DataRuns")
DataRuns$SC <-"error"
for ( id in unique(DataAssetsByID$NewHouseID) ){
  idName = paste(id,".H2K",sep="")
  DataRuns$SC[ DataRuns$archetype.h2k.File ==  idName ] = DataAssetsByID$ServiceCentre[ DataAssetsByID$NewHouseID == id ]
  DataRuns$weatherLoc[ DataRuns$archetype.h2k.File ==  idName ] = DataAssetsByID$Weather[ DataAssetsByID$NewHouseID == id ]
  DataRuns$regionLoc[ DataRuns$archetype.h2k.File ==  idName ] = DataAssetsByID$Region[ DataAssetsByID$NewHouseID == id ]
}

head.out("Heat Loss Analysis")
DataRuns$hlDeltaT <- 18 - DataRuns$output.DesignTemp.Heating.oC
DataRuns$hlDesignLoad <- DataRuns$output.PEAK.Heating.W
DataRuns$hlWattPerM3 <- DataRuns$hlDesignLoad / DataRuns$archetype.House.Volume.m3
DataRuns$ACH <- DataRuns$archetype.Archetype.ACH



head.out("Classifying")
msg.out("Source")
DataRuns$DataSource = "error"
DataRuns$DataSource <- sub("CFHA-","",sub("-[0-9]+.H2K","",DataRuns$archetype.h2k.File))

msg.out("Year of evaluation")
DataRuns$archetype.EvaluationYr <- sub("-[0-9][0-9]-[0-9][0-9]","",DataRuns$archetype.EvaluationDate)
DataRuns$archetype.AuditTrigger <- sub("2020","CE-O",DataRuns$archetype.EvaluationYr)
DataRuns$archetype.AuditTrigger <- sub("[0-9][0-9][0-9][0-9]","CFHA",DataRuns$archetype.AuditTrigger )
DataRuns$archetype.AuditTrigger[ DataRuns$DataSource == "Proxy" ] <- "Proxy"
unique(DataRuns$archetype.AuditTrigger)

unique(DataRuns$input.Opt.Ruleset)

DataRuns$MdlSet = "error"
DataRuns$MdlSet[DataRuns$input.Opt.Ruleset == "as-found" & DataRuns$archetype.AuditTrigger == "CFHA" ]  <- "recapped"
#DataRuns$MdlSet[DataRuns$input.Opt.Ruleset == "ArchetypeRoadmapping_auto" & DataRuns$archetype.AuditTrigger == "CFHA" ] <- "untouched"
DataRuns$MdlSet[DataRuns$input.Opt.Ruleset == "as-found" & DataRuns$archetype.AuditTrigger == "Proxy" ] <- "untouched"
DataRuns$MdlSet[DataRuns$input.Opt.Ruleset == "as-found" & DataRuns$archetype.AuditTrigger == "CE-O" ]  <- "untouched"

AssumedBestACH = rep(6.0, length(DataRuns$MdlSet[DataRuns$MdlSet == "untouched"]))

DataRuns$archetype.Archetype.ACH[DataRuns$MdlSet == "untouched"] <- pmax(DataRuns$archetype.Archetype.ACH[DataRuns$MdlSet == "untouched"], AssumedBestACH )

msg.out ("Sets for modelling.")
table(DataRuns$MdlSet)

msg.out ("subset: CFHA audits (recap)")
dataRCHomes <- subset(DataRuns, MdlSet == "recapped")


dataOGHomes <- subset(DataRuns, MdlSet == "untouched")


head.out("Modelling:")



mdlRCHomes <- lm ( hlWattPerM3 ~ ACH * hlDeltaT, dataRCHomes )
mdlOGHomes <- lm ( hlWattPerM3 ~ ACH * hlDeltaT, dataOGHomes )

msg.out("recapped model")

summary(mdlRCHomes)
msg.out("untouched model")
summary(mdlOGHomes)

head.out ("Building SC HL table")

SCSizes = data.frame(SCName = unique(DataRuns$SC))


# Attempt to classify by SC
for (mySC in SCSizes$SCName ){
  SCSizes$CZ[SCSizes$SCName==mySC ] <- DataRuns$archetype.climate.zone[ DataRuns$SC==mySC ][1]
  SCSizes$Region[SCSizes$SCName==mySC ] <- DataRuns$regionLoc[ DataRuns$SC==mySC ][1]
  SCSizes$DesignTemp[  SCSizes$SCName==mySC ] <- mean( DataRuns$output.DesignTemp.Heating.oC[ DataRuns$SC==mySC ] )
  SCSizes$hlDeltaT[  SCSizes$SCName==mySC ] <- mean(DataRuns$hlDeltaT[ DataRuns$SC==mySC ])
  SCSizes$HDD[  SCSizes$SCName==mySC ] <- mean( DataRuns$output.HDDs[ DataRuns$SC==mySC ] )
  
  achData = dataRCHomes$archetype.Archetype.ACH[ dataRCHomes$SC==mySC ] 
  count = length(achData)
  achMean = median (achData)
  achStdDev =  sd(achData) 
  achQuartile= quantile(achData, probs = c(0.01,0.99), names=FALSE)

  SCSizes$RC.Count[  SCSizes$SCName==mySC ] <- count
  SCSizes$RC.MeanACH[  SCSizes$SCName==mySC ] <- achMean
  SCSizes$RC.LowACH[  SCSizes$SCName==mySC ]  <- achQuartile[1]
  SCSizes$RC.HighACH[  SCSizes$SCName==mySC ]  <- achQuartile[2]

  achData = dataOGHomes$archetype.Archetype.ACH[ dataOGHomes$SC==mySC ] 
  count = length(achData)
  achMean = median (achData)
  achStdDev =  sd(achData) 
  achQuartile= quantile(achData, probs = c(0.01,0.99), names=FALSE)

  SCSizes$OG.Count[  SCSizes$SCName==mySC ] <- count
  SCSizes$OG.MeanACH[  SCSizes$SCName==mySC ] <- achMean
  SCSizes$OG.LowACH[  SCSizes$SCName==mySC ]  <- achQuartile[1]
  SCSizes$OG.HighACH[  SCSizes$SCName==mySC ]  <- achQuartile[2]

}

#SCSizes = data.frame(SCName = unique(DataRuns$SC))
#for (mySC in SCSizes$SCName ){
#  SCSizes$Region[SCSizes$SCName==mySC ] <- DataRuns$regionLoc[ DataRuns$SC==mySC ][1]
#  SCSizes$DesignTemp[  SCSizes$SCName==mySC ] <- mean( DataRuns$output.DesignTemp.Heating.oC[ DataRuns$SC==mySC ] )
#  SCSizes$hlDeltaT[  SCSizes$SCName==mySC ] <- mean(DataRuns$hlDeltaT[ DataRuns$SC==mySC ])
#  SCSizes$HDD[  SCSizes$SCName==mySC ] <- mean( DataRuns$output.HDDs[ DataRuns$SC==mySC ] )
#  
#}

# Now apply corser by region averages for SC's with dubious data
for (myRegion in c("ONTARIO", "BRITISH COLUMBIA", "NOVA SCOTIA", "QUEBEC",  "NEWFOUNDLAND AND LABRADOR", "QUEBEC", "ALBERTA", "MANITOBA") ){

 
  achData = dataRCHomes$archetype.Archetype.ACH[ dataRCHomes$regionLoc==myRegion ] 
  count = length(achData)
  achMean = median (achData)
  achStdDev =  sd(achData) 
  achQuartile= quantile(achData, probs = c(0.01,0.99), names=FALSE)


  SCSizes$RC.MeanACH[ SCSizes$Region==myRegion ] <- achMean
  SCSizes$RC.LowACH[ SCSizes$Region==myRegion ]  <- achQuartile[1]
  SCSizes$RC.HighACH[ SCSizes$Region==myRegion ]  <- achQuartile[2]

  achData = dataOGHomes$archetype.Archetype.ACH[ dataOGHomes$regionLoc==myRegion ] 
  count = length(achData)
  achMean = median (achData)
  achStdDev =  sd(achData) 
  achQuartile= quantile(achData, probs = c(0.01,0.99), names=FALSE)

  
  SCSizes$OG.MeanACH[  SCSizes$Region==myRegion ] <- achMean
  SCSizes$OG.LowACH[  SCSizes$Region==myRegion ]  <- achQuartile[1]
  SCSizes$OG.HighACH[  SCSizes$Region==myRegion ]  <- achQuartile[2]

}

# 

for (myRegion in c("ONTARIO", "BRITISH COLUMBIA", "NOVA SCOTIA", "QUEBEC",  "NEWFOUNDLAND AND LABRADOR", "QUEBEC", "ALBERTA", "MANITOBA") ){

 
  achData = dataRCHomes$archetype.Archetype.ACH[ dataRCHomes$regionLoc==myRegion ] 
  count = length(achData)
  achMean = median (achData)
  achStdDev =  sd(achData) 
  achQuartile= quantile(achData, probs = c(0.01,0.99), names=FALSE)


  SCSizes$RC.MeanACH[ SCSizes$Region==myRegion ] <- achMean
  SCSizes$RC.LowACH[ SCSizes$Region==myRegion ]  <- achQuartile[1]
  SCSizes$RC.HighACH[ SCSizes$Region==myRegion ]  <- achQuartile[2]

  achData = dataOGHomes$archetype.Archetype.ACH[ dataOGHomes$regionLoc==myRegion ] 
  count = length(achData)
  achMean = median (achData)
  achStdDev =  sd(achData) 
  achQuartile= quantile(achData, probs = c(0.01,0.99), names=FALSE)

  
  SCSizes$OG.MeanACH[  SCSizes$Region==myRegion ] <- achMean
  SCSizes$OG.LowACH[  SCSizes$Region==myRegion ]  <- achQuartile[1]
  SCSizes$OG.HighACH[  SCSizes$Region==myRegion ]  <- achQuartile[2]

}


for ( region in c("SASKATCHEWAN","NORTHWEST TERRITORIES")){
  SCSizes$OG.MeanACH[ SCSizes$Region==region ] <-mean(SCSizes$OG.MeanACH[ SCSizes$Region=="ALBERTA" ])
  SCSizes$OG.LowACH[  SCSizes$Region==region ] <-mean(SCSizes$OG.LowACH[  SCSizes$Region=="ALBERTA" ])
  SCSizes$OG.HighACH[ SCSizes$Region==region ] <-mean(SCSizes$OG.HighACH[ SCSizes$Region=="ALBERTA" ]) 
}

# Finally - bodge data to correct dubious numbers where there is uncertianty. 
for ( region in c("ALBERTA","MANITOBA")){
# ALBERTA. Cold lake forms biggest set; recapped data shows no siginficant improvement
  SCSizes$OG.MeanACH[ SCSizes$Region==region ]  <-   SCSizes$RC.MeanACH[ SCSizes$Region==region ] * 1.1 
  SCSizes$OG.LowACH[  SCSizes$Region==region ]  <-   SCSizes$RC.LowACH[  SCSizes$Region==region ] * 1.1 
  SCSizes$OG.HighACH[ SCSizes$Region==region ]  <-   SCSizes$RC.HighACH[ SCSizes$Region==region ] * 1.1 
}
for (region in c("NEWFOUNDLAND AND LABRADOR", "NORTHWEST TERRITORIES","QUEBEC", "SASKATCHEWAN"))  {
  SCSizes$RC.MeanACH[ SCSizes$Region==region ]  <-   SCSizes$OG.MeanACH[ SCSizes$Region==region ] / 1.1 
  SCSizes$RC.LowACH[  SCSizes$Region==region ]  <-   SCSizes$OG.LowACH[  SCSizes$Region==region ] / 1.1 
  SCSizes$RC.HighACH[ SCSizes$Region==region ]  <-   SCSizes$OG.HighACH[ SCSizes$Region==region ] / 1.1 
}

SCSizes$OG.LowACH[  SCSizes$Region=="NEWFOUNDLAND AND LABRADOR" ] <- SCSizes$OG.MeanACH[ SCSizes$Region=="NEWFOUNDLAND AND LABRADOR" ] + 2*sd(SCSizes$OG.MeanACH)
SCSizes$OG.HighACH[ SCSizes$Region=="NEWFOUNDLAND AND LABRADOR" ] <- SCSizes$OG.MeanACH[ SCSizes$Region=="NEWFOUNDLAND AND LABRADOR" ] - 2*sd(SCSizes$OG.MeanACH)

for (region in SCSizes$Region ){

  SCSizes$VolMean[SCSizes$Region == region] <- mean(DataRuns$archetype.House.Volume.m3[ DataRuns$regionLoc == region ])
  SCSizes$VolMax[SCSizes$Region == region] <- max(DataRuns$archetype.House.Volume.m3[ DataRuns$regionLoc == region ])
  SCSizes$VolMin[SCSizes$Region == region] <- min(DataRuns$archetype.House.Volume.m3[ DataRuns$regionLoc == region ])

}

SCSizes$VolMean <- mean(DataRuns$archetype.House.Volume.m3)
SCSizes$VolMin  <-  quantile(DataRuns$archetype.House.Volume.m3, probs = c(0.05,0.95), names=FALSE)[1]
SCSizes$VolMax  <-  quantile(DataRuns$archetype.House.Volume.m3, probs = c(0.05,0.95), names=FALSE)[2]



head.out("Applying heat loss models")
  #SCSizes$RC.LowACH[  SCSizes$SCName==mySC ]  <- achMean - achStdDev * 1

achCalc = data.frame(ACH = SCSizes$OG.MeanACH, hlDeltaT = SCSizes$hlDeltaT    )
SCSizes$OG.hlWattPerM3.mean<- predict(mdlOGHomes, newdata = achCalc)
achCalc = data.frame(ACH = SCSizes$OG.LowACH, hlDeltaT = SCSizes$hlDeltaT    )
SCSizes$OG.hlWattPerM3.low<- predict(mdlOGHomes, newdata = achCalc)
achCalc = data.frame(ACH = SCSizes$OG.HighACH, hlDeltaT = SCSizes$hlDeltaT    )
SCSizes$OG.hlWattPerM3.high<- predict(mdlOGHomes, newdata = achCalc)

achCalc = data.frame(ACH = SCSizes$RC.MeanACH, hlDeltaT = SCSizes$hlDeltaT    )
SCSizes$RC.hlWattPerM3.mean<- predict(mdlRCHomes, newdata = achCalc)
achCalc = data.frame(ACH = SCSizes$RC.LowACH, hlDeltaT = SCSizes$hlDeltaT    )
SCSizes$RC.hlWattPerM3.low<- predict(mdlRCHomes, newdata = achCalc)
achCalc = data.frame(ACH = SCSizes$RC.HighACH, hlDeltaT = SCSizes$hlDeltaT    )
SCSizes$RC.hlWattPerM3.high<- predict(mdlRCHomes, newdata = achCalc)



SCSizes$OG.HLwatts.low  <- SCSizes$OG.hlWattPerM3.low   * SCSizes$VolMin
SCSizes$OG.HLwatts.mean <- SCSizes$OG.hlWattPerM3.mean  * SCSizes$VolMean
SCSizes$OG.HLwatts.high <- SCSizes$OG.hlWattPerM3.high  * SCSizes$VolMax

SCSizes$RC.HLwatts.low  <- SCSizes$RC.hlWattPerM3.low   * SCSizes$VolMin
SCSizes$RC.HLwatts.mean <- SCSizes$RC.hlWattPerM3.mean  * SCSizes$VolMea
SCSizes$RC.HLwatts.high <- SCSizes$RC.hlWattPerM3.high  * SCSizes$VolMax

#new.speeds <- data.frame(
#  speed = c(12, 19, 24)
#)
#You can predict the corresponding stopping distances using the R function predict() as follow:
#
#predict(model, newdata = new.speeds)


cat("\n")
print(SCSizes[order(SCSizes$Region),])

fwrite (SCSizes, "CFHA-sizing-table.csv")
fwrite (DataRuns, "CFHA-loads.csv")

warnings()