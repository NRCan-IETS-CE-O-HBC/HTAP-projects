# Impact Analysis of ERS Alignment #

> Authors<br />
> Adam Wills (Adam.Wills@nrc-cnrc.gc.ca) <br />
> Construction Research Centre, National Research Council Canada
>
> Version of June 6, 2019

## HTAP Version Info.
Branch: `NBC-codes`
Commit: `a4dedc020afaecdde7a5785ff161fb97c01df1aa`
Local changes (found in `mod_files`):
- `HTAP-options.json`
- `HTAPUnitCosts.json`

## Background ##
These files are part of NRC research's impact analysis of PCF 1608. This change request seeks to align the building operating conditions prescribed in Subsection 9.36.5 with the EnerGuide Rating System. Three operating conditions are altered in PCF 1608: heating setpoint temperature, internal gains, and hot water consumption. The justification given for PCF 1608 is to provide continuity between the national building code and other programs active within Canada.

## Objectives ##
The purpose of this work is to use HTAP to evaluate the potential impacts arising from PCF 1608.

## Method ##
Archetypes 4 and 11 were selected for analysis. Archetype 4 represents a single-family home with nominal energy performance. Archetype 11 is a mid-row single-family unit included to acknowledge the increase of attached home construction in Canada. Each archetype was modelled in a major housing market in each climate zone. HTAP was used to convert the archetypes to their climate-relevant code-references.
###### **a)Baseline performance of the archetypes were established using HTAP**
- `Baseline_2015.run`
###### **b)Baseline performance of the archetypes were established assuming the operating conditions in PCF 1608**
- `Baseline_ERS.run`
###### **c)For each archetype, climate, and operating condition two different sets of ECMs were applied:**
- Wall measures
    - `Walls_2015.run`
    - `Walls_ERS.run`
- Hot water system measures
    - `DHW_2015.run`
    - `DHW_ERS.run`
###### **d)For each archetype, climate, operating condition, and ECM the relative **

## Summary of Findings ##
The simulation analysis found that PCF 1608 alters the distribution of energy end-uses in the total building energy consumption. The share of space heating allocated to total energy was found to increase by 3% to 4%. Hot water and plug loads take a smaller portion of the total energy consumption. The implications of this was that relative total energy reduction was higher when PCF 1608 operating conditions are used. Conversely, relative total energy reductions from energy conservation measures (ECMs) targeting hot water demand have reduced efficacy. Therefore, the potential implications of PCF 1608 is incentivizing envelope improvements over hot water system ECMs. It was noted, however, that the absolute differences in incremental performance were less than 2% reduction in total energy consumption. Therefore, the analysis suggests minimal impact on Subsection 9.36.5.

## Results Files ##

Raw results are located in `results/ERS_Alignment_Analysis.accde`, which in an Access Database.



