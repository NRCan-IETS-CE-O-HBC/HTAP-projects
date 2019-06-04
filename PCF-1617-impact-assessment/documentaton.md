# Feasibility assessment of tiered performance codes

> Authors<br />
> CanmetENERGY-Ottawa, Natural Resources Canada
>
> Version of May 17, 2019. <br />This is a draft document, and reflects interim findings from a ongoing study. <br />Documentation and relevant project files are maintained at https://github.com/NRCan-IETS-CE-O-HBC/HTAP-projects

## Summary of Findings

## Background

### Objectives:

CE-O researchers investigated the feasibility of upgrading new Canadian homes to achieve the energy tiers proposed in PCF-1617. Our objectives were to: 

-  Determine if each of the energy energy tiers can be achieved using any or all of the energy conservation measures commonly used in Canadian low-energy construction
-  Identify regions and housing archetypes for which the tiers appear to be infeasible
-  Estimate cost ranges for achieving the energy tiers in different regions and energy requirements. 
-  If necessary, recommend changes to PCF-1617 to improve feasibility.

### Scope:

Our investigation into the feasibility of PCF-1617 included:

-  Examining how different air tightness targets would impact a home's envelope and overall performance improvement
-  Examining the likelihood that the envelope performance targets can be achieved using high-performance envelopes commonly used in low-energy and net-zero energy construction
-  Examining the likelihood that the overall performance targets can be met using broadly-available electric, gas, and oil-fueled heating equipment

==As part of this study, we considered a variety of archetypes, locations ...==

## Proposed Requirements for a tiered energy code

PCF 1617 proposes five energy tiers. The lowest tier — tier 1— aligns with the minimum requirements of NBC 9.36.  Each of the subsequent tiers sets forward performance requirements  

1. *Airtightness levels:* - specific air-tightness targets that must be verified through a blower-door test.
2. *Envelope performance improvement:*Energy efficiency savings that must be achieved through envelope improvements alone (air-tightness, insulation, glazing, solar design), and demonstrated through performance modelling.
3. *Overall Performance improvement:* Energy efficiency savings that must be achieved through envelope and mechanical system improvements (excluding renewable energy systems), and demonstrated through performance modelling.

To comply with a given tier, a home must meet all of the requirements for that tier. Failure to meet any of the requirements for a given tier will cause a home to be deemed compliant with a lower tier. 

### Airtightness levels ###

A separate proposed change form (PCF 1610) defines 5 air-tightness performance levels, with ACH, NLA and NLR evaluation methods. For detached buildings, or for attached buildings/zones evaluated using guarded testing, the Air-tightness levels are defined as follows: 

| Air-Tightness Level - Single zone & Guarded testing | ACH  | NLA(10)  | NLR(50)     |
| --------------------------------------------------: | ---- | -------- | ----------- |
|                                                   1 | 2.5  | 1.20 cm² | 0.89 l/s/m² |
|                                                   2 | 2.0  | 0.96     | 0.71        |
|                                                   3 | 1.5  | 0.72     | 0.53        |
|                                                   4 | 1.0  | 0.48     | 0.35        |
|                                                   5 | 0.6  | 0.29     | 0.21        |

For attached zones evaluated using unguarded testing, the Air-tightness levels are defined as follows: 
| Air-Tightness Level - Attached zone & unguarded testing | ACH  | NLA(10)  | NLR(50)     |
| ------------------------------------------------------: | ---- | -------- | ----------- |
| 0 | 3.0 | 1.92 cm² |1.17 l/s/m²|
|                                                       1 | 2.5 | 1.60 | 0.98 |
|                                                       2 | 2.0 | 1.28  | 0.78       |
|                                                       3 | 1.5 | 0.96 | 0.59       |
|                                                       4 | 1.0 | 0.64   | 0.39       |
|                                                       5 | 0.6 | 0.38     | 0.23       |

### Building envelope performance improvement ###

To comply with a tier, a home must meet its prescribed building envelope performance requirement. From PCF 1617:

> [**9.36.6.2 (5)**]  "*For the purpose of compliance with Tables 9.36.6.2.-A and -B, Envelope Performance Improvement is the **difference in energy use** between the proposed building and the reference building:*
>
>       *[a] including equipment, systems, and assemblies within the scope of 9.36.2., and* <br />   *[b] excluding differences in mechanical equipment within the scope of 9.36.3. and 9.36.4."*

Note that this requirement is measured based on whole building performance (including space heating, hot water, ventilation, cooling), even though the effects envelope measures in the scope of 9.36.2 are largely limited to space heating.  [^a]


### Overall Performance improvement ###

To comply with a tier, a home must meet its prescribed building envelope performance requirement. From PCF 1617:

>  [**9.36.6.2 (4)**]  “*For the purpose of compliance with Tables
>9.36.6.2.-A and -B, Overall Energy Performance Improvement is the difference in energy use between the proposed
>  building and the reference building, expressed as a percentage of the total
>energy use of the reference building and excluding electrical base loads
>  related to lighting, plug loads and appliances (see note 9.36.6.2.(1)).*"

### Performance Tiers ###

Using those definitions, PCF 1617 defines the following performance tiers for dwellings containing greater than 230m³ of conditioned space:

**TABLE 2: Performance tiers for dwellings containing greater than 230m³ of conditioned space**

| Tier | Air-tightness level | Envelope Performance Improvement (%) | Overall Energy Performance Requirement (%) |
| ---- | ------------------: | -----------------------------------: | -----------------------------------------: |
| 1    |       Test only[^b] |                             $\geq 0$ |                                   $\geq 0$ |
| 2    |             Level 1 |                             $\geq 5$ |                                  $\geq 10$ |
| 3    |             Level 1 |                            $\geq 10$ |                                  $\geq 20$ |
| 4    |             Level 3 |                            $\geq 20$ |                                  $\geq 40$ |
| 5    |             Level 3 |                            $\geq 50$ |                                  $\geq 70$ |

**TABLE 3: Performance tiers for dwellings  with conditioned space not greater than 230m³**

| Tier | Air-tightness level | Envelope Performance Improvement (%) | Overall Energy Performance Requirement (%) |
| ---- | ------------------: | -----------------------------------: | -----------------------------------------: |
| 1    |       Test only[^b] |                             $\geq 0$ |                                   $\geq 0$ |
| 2    |             Level 1 |                             $\geq 0$ |                                  $\geq 0 $ |
| 3    |             Level 1 |                             $\geq 5$ |                                  $\geq 10$ |
| 4    |             Level 3 |                            $\geq 15$ |                                  $\geq 30$ |
| 5    |             Level 3 |                            $\geq 35$ |                                  $\geq 60$ |

## Method

#### Research Question #1)  ####

###### a) determine how far air tightness level targets go to reaching envelope & performance targets

- configure a HTAP file (`air-tigtness-levels.run`)  that configures the 9.36 reference house with each of the prescribed air tightness levels.  
- Run evaluation across all 240 archetypes, in select locations 
- Evaluate % improvement relative to the reference house (both envelope, mechanical) achieved via air-tightness, compare to targets in each tier. 

*Question:* How much further would those builders have to go?

###### **b) evaluate feasibility of building envelope target**

- configure a HTAP file (`envelope-feasibility.run`) to apply highest performing insulation / glazing / air tightness levels.
- Run evaluation across all 240 archetypes, in same select locations. Evaluate if the envelope performance tiers were achieved (remember small homes get different tiers)

*Questions:* 

  - Which homes achieved targets, and by how much? Which did not, and why not? Where were they located? What additional measures could be applied?
  - How much might it cost to achieve each tier envelope target? 
  - How would those costs vary by archetype and region?

###### c) evaluate feasibility of total performance target

- configure a HTAP file  (`overall-feasibility.run`) to apply highest performing insulation / glazing / air tightness levels, along with 4 reference mechanicals (==maybe this requires 4 htap files?==):

| Scenario              | SH             | WH                              | Vent     |
| --------------------- | -------------- | ------------------------------- | -------- |
| Electrical resistance | Baseboard      | Electric storage + DWHR         | Best HRV |
| Efficienct Gas        | Condensing gas | Condensing tankless+ DWHR       | Best HRV |
| Air heat pump         | CCASHP         | HPWH (indoor evaporator)+ DWHR  | Best HRV |
| Ground heat pump      | GSHP           | HPWH (outdoor evaporator)+ DWHR | Best HRV |




- Run evaluation across all 240 archetypes, in same select locations. Evaluate if the overall performance tiers were achieved (remember small homes get different tiers)

*Questions:* 

- Which homes achieved targets, and by how much? Which did not, and why not? Where were they located? What additional measures could be applied?
- Do some homes achieve envelope tier but not overall tier (or vice versa?)
- How much might it cost to achieve each tier envelope target? 
- How would those costs vary by archetype and region?



## Findings

#### 1) Contribution of air-tightness on overall energy savings ####

CE-O examined the energy savings achieved by increasing air-tightness from 2.5 ACH to 0.6. This analysis considered 2 archetypes in ==X== locations.

| File                                                  |
| ----------------------------------------------------- |
| HTAP Run: `feasibility-ACH-2-archetypes.run`          |
| Results:  `feasibility-ACH-2-archetypes.json`         |
| Tableau analysis:  `feasibility-ACH-2-archetypes.twb` |



## Notes ##

[^a]:   This definition may prove problematic.  Envelope improvements can only affect a building’s space heating and space cooling (if equipped) energy use. Builders are expected to reduce overall energy use by 35% or more, using measures that only affect a fraction of overall energy use. This approach will make it easier to hit envelope targets in colder locations, because space heating is a bigger fraction of overall energy impacts (see pictures below -- comparing the % impact of air tightness improvements relative to the NBC.). In warmer locations, builders will have to work harder to hit the envelope target .   ![1559678720973](imgs/1559678720973.png) Consider proposing alternative requirment based on space heating alone. 



[^b]: To comply with tier 0, builders must complete an air-tightness test, but are not required to demonstrate a performance value. 

###  ###