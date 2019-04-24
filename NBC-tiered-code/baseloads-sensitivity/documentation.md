# Examining the effect of occupancy assumptions on absolute energy metrics (such as TEDI, MEUI) #

>  Alex Ferguson, Natural Resources Canada. 
>
>  March 13, 2019

## Synopsys ##

These models are used to study the effect of different baseloads on TEDI, MEUI metrics. 

## Background ##

Electrical and hot water use affect compliance under performance codes: 

-  Site electrical consumption

-  Energy use by water heating equipment

-  Heat gains from electrical equipment, water use,  and occupants.

The impact of these assumptions are mitigated somewhat in the reference building approach, which compares results for two buildings with the same assumptions. 

But getting these assumptions right is critical for codes based on absolute consumption metrics, like the TEDI and MEUI used in the step code. That’s because the benchmark metrics are not sensitive to the assumptions used.

#### Hypothesis: ####

Compliance paths under absolute metrics (such as TEDI, MEUI) will be more sensitive to assumptions about occupancy, appliance and lighting use than reference building approaches. This is because the intensity target in the does not change to reflect different occupancy assumptions. Furthermore, the current occupancy/appliance and lighting assumptions stipulated in 9.36 are out of date — they will provide easier and less-expensive compliance pathways than if more realistic assumptions are used.

## Method: ##

1. ==To be documented.==


## Findings: ##

Hypothesis was confirmed. 

#### 1) Effect of baseloads on TEDI ####

This graph examines how assumptions about
occupancy affect TEDI results for a house in Toronto. Heat gains from the
baseloads offset heating requirements; Higher baseload assumptions produce
lower TEDI results. Depicted are the current NBC assumptions, standard ERS
assumptions, and reduced ERS assumptions that are available to NZE homes. 

![1556125396102](C:\HTAP-projects\NBC-tiered-code\baseloads-sensitivity\imgs\baseload-comparisons.png)

#### 2) Effect of baseloads on costs to meet TEDI target ####

Not surprisingly, the costs to achieve a
given TEDI step are also affected by baseload assumptions.  If
EESHB assumes higher baseloads, cost-benefit analysis will show lower upgrade
costs and more attractive outcomes. 
More
realistic assumptions are likely to produce more pessimistic scenarios. 

![1556125470088](C:\HTAP-projects\NBC-tiered-code\baseloads-sensitivity\imgs\baseloads&Costs.png)

#### 3) Effect of baseloads on TEDI, by heated floor area ####

These effects are not uniform across all homes. This graph examines the effect baseload assumptions on estimated TEDIs for 50 different homes.  Switching from the current NBC loads to more realistic estimates dramatically increases TEDI in smaller homes.

![1556125559376](C:\HTAP-projects\NBC-tiered-code\baseloads-sensitivity\imgs\baseloads-by-house-size.png)

#### Recommendations ####

Before the costs and impacts of an intensity-based code can be understood, current assumptions about occupancy and internal gains must be examined, and updated reflect more recent data on Canadian households. 

This assessment will be essential for any work on absolute energy metrics —like the TEDI and MEUI —because these metrics are much more sensitive to baseload and internal gain assumptions. 

##  Instructions for reproducing these results in HTAP ##

###### 1) Effect of baseloads on TEDI ######

```
> C:\htap\htap-prm.rb -r .\TEDI-base-load.run -o C:\htap\HTAP-options.json -v -j -t 3 -c
```

######  2) Effect of baseloads on costs to meet TEDI target ######

```
> C:\htap\htap-prm.rb -r .\TEDI-base-load.run -o C:\htap\HTAP-options.json -v -j -t 3 -c
```

###### 3) Effect of baseloads on TEDI, by heated floor area ######

First ensure that NRCan's new housing archetypes are installed at `C:/HTAP/Archetypes/NewHouseArch` (or edit the `archetype-dir` entry in file.\TEDI-by-floor-area.run to reflect the appropraiate location )

```
> C:\htap\htap-prm.rb -r .\TEDI-by-floor-area.run -o C:\htap\HTAP-options.json -v -j -t 3 -c
```

