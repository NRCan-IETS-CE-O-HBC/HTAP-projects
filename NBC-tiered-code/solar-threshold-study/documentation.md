# Proposed metrics to control risks of overheating in future residential energy codes #

>  Julia Purdy, Chris Kirney & Alex Ferguson, <br />
>  CanmetENERGY Ottawa, Natural Resources Canada
>
>  Contact: julia.purdy@canada.ca
>
>  April 25, 2019

[TOC]

## Synopsys ##

These files are part of an investigation into overheating in residential housing. The goal of this study is to propose a metric for evaluating the likelihood of a home to overheat relative to the reference house. Results from this study will also demonstrate how code requirements based on that metric would affect home design. 

## Background ##

Performance compliance may encourage designers to increase solar gains through windows as a low-cost means to reduce energy consumption. If designers do not consider the implications of adverse gains in summer, these homes may require significant cooling loads, and may be uncomfortable in summer. 

#### Hypothesis ####

*By comparing the **a) peak cooling loads** and/or **b) seasonal cooling requirements** between the proposed design and the reference house, a future code requirement can limit the likelihood that designers will use excessive solar gains to meet higher energy tiers.* 

#### Objectives:  ####

1. Propose a requirement limiting a designer's ability to trade-off reduced heating for increased cooling loads as a means to meet upper tiers
2. Develop evidence supporting that requirement, and identifying how the requirement is likely to limit home design. 

#### Guiding principles: ####

-  **The scope of this study is limited to home design** (orientation, glazing areas, overhangs), glazing specifications (solar heat gain coefficient), and operable windows. 
-  If proposed requirement stipulates the home be modelled with cooling, **these modelling procedures shall only be required for the purposes of assessing overheating risks**. They shall not be interpreted to mean that the code requires homes be equipped with air conditioners, or that the home shall

>  **NOTE**: The scope of this study specifically excludes examining whether or not a home will require cooling, or appropriate performance levels for cooling equipment. The metrics proposed in this study, and the data collected to support them will be inadequate to examine these other issues. If they are important for future codes, additional studies will be required.

-  **The metric will be computed using the reference house approach**. We recognize that housing design tools predict cooling with different degrees of accuracy. As part of this with the requirement, the designer must compare the cooling loads for the proposed design to those of the reference house. If the the proposed design's predicted cooling loads do not exceed the reference house by more than ==X%==, then the home will be deemed to comply with this requirement. 
-  **The requirement shall not restrict appropriate passive solar design.** The metric (and threshold ==X%==) will be chosen to permit designers enough flexibility to design a home to well-known passive solar principles (south glazing =~ 4-6% of floor area, windows are protected by appropriate overhangs, N/E/W glazing is limited).

#### Possible language for the proposed requirement ####

1. The reference house and proposed design shall be modelled in accordance with 9.36.5

2. For the purposes of demonstrating the proposed design does not increase risks of overheating, models for both the reference house and proposed design shall be equipped with appropriately-sized[^1] space cooling equipment that serves all occupied spaces within the building.[^2]

3. The relative difference in cooling requirements between the reference house and the proposed design shall be calculated as follows: 
   $$
   \delta QC = \frac{QC_{proposed}-QC_{reference}}{QC_{reference}}\cdot 100
   $$
   Where:
   
   $\delta{}QC$ is the  relative difference in the cooling requirements between the reference and proposed houses
   
   $QC_{proposed}$ is the  cooling requirement of the proposed house
   
   $QC_{reference}$ is the  cooling requirement of the reference house
   

<!-- Note that QC to be explicitly defined as Peak cooling load (W) or seasonal cooling requrement (GJ), based on findings from this study -->

4. The peak cooling load in the proposed design shall not exceed the peak cooling load in the reference house by more than ==X%==.

[^1]: Do we need to reference F280 here?
[^2]: The performance of the cooling equipment should be unimportant, because the requirement focuses on the peak cooling load, or seasonal cooling requirement.

## Method: ##

1. Using archetype homes, compare peak cooling loads for the reference house, for  the same house designed to well-known passive solar guidelines, and to worst case scenarios (E/W orientations, excessive, unshaded glazing). 
- starting with Arch-1-NZEH-detached-2-story.h2k
- modify window distribution to equal in each cardinal direction; this is the base case
- modify to have 6% window area (to heated floor area) on the south side of the house with the same overall window to heated floor area; this is the passive solar case
- modify archetype to maximize window area on east and west sides with same overall window to heated floor area; this is the worst case scenario

2. Propose a maximum ‘permitted increase in cooling loads’ threshold (e.g. 25%), which affords enough flexibility to design passive solar homes, but restricts ‘worst-case scenario’ homes. 

3. Verify that the threshold produces similar results across different building simulation software

4. Examine impact of the proposed metric using 240 archetypes in a variety of locations. For those that could not meet proposed requirements, identify characteristics that prevent the archetypes from meeting the requirement. 

   

## Findings: ##



##  HTAP instructions: ##

Example run:

```
C:\HTAP-projects\NBC-tiered-code\solar-threshold-study> C:\htap\htap-prm.rb -r .\example.run -o C:\htap\HTAP-options.json -v -j -t 2 -c
```

 

<!-- more here-->

