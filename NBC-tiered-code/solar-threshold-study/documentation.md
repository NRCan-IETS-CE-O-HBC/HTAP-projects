# Solar Threshold Study #

>  Julia Purdy, Natural Resources Canada. Contact: julia.purdy@canada.ca
>
>  April 25, 2019

## Synopsys ##

These models are used to study the impact of overheating in Part 9 buildings.

## Background ##

Performance compliance may encourage designers to increase solar gains through windows as a low-cost means to reduce energy consumption. If designers do not consider the implications of adverse gains in summer, these homes may require significant cooling loads, and may be uncomfortable in summer. 

#### Hypothesis ####

*By comparing the peak cooling loads between the proposed design and the reference house, a future code requirement can limit the likelihood that designers will use excessive solar gains to meet higher energy tiers.* 

#### Objectives:  ####

1. Propose a requirement limiting a designer's ability to trade-off reduced heating for increased cooling loads as a means to meet upper tiers
2. Develop evidence supporting that requirement, and identifying how the requirement is likely to limit home design. 

#### Guiding principles: ####

-  **The code will not mandate air conditioning.** The metric for the proposed requirement shall be the increase in cooling load that would be observed *if* an air conditioner were to be installed. Builders will not be required to install air conditioning to comply with this requirement.
-  **The metric will be computed using the reference house approach**. We recognize that housing design tools predict cooling with different degrees of accuracy. As part of this with the requirement, the designer must compare the cooling loads for the proposed design to those of the reference house. If the the proposed design's predicted cooling loads do not exceed the reference house by more than ==X%==, then the home will be deemed to comply with this requirement. 
-  **The requirement shall not restrict appropriate passive solar design.** The metric (and threshold ==X%==) will be chosen to permit designers enough flexibility to design a home to well-known passive solar principles (south glazing =~ 4-6% of floor area, windows are protected by appropriate overhangs, N/E/W glazing is limited).

#### Possible language for the proposed requirement ####

1. For the purposes of demonstrating the proposed design does not increase risks of overheating, models for both the reference house and proposed design shall be equipped with space cooling equipment that serve all occupied spaces within the  dwelling. 
2. The setpoints for cooling shall as provided in table X ==(AKA ERS)==
3. The peak cooling load in the proposed design shall not exceed the peak cooling load in the reference house by more than ==X%==.
     



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