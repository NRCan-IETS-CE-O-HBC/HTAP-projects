# Feasibility of Performance Tier 5 in Future Energy codes

> Authors<br />
> CanmetENERGY-Ottawa, Natural Resources Canada
>
> Version of May 17, 2019. <br />This is a draft document, and reflects interim findings from a ongoing study. <br />Documentation and relevant project files are maintained at https://github.com/NRCan-IETS-CE-O-HBC/HTAP-projects

## Summary of Findings

## Background

### Objectives:

### Scope:

### Guiding Principles:

## Method

==**Working notes**==

###### a) determine how far air tightness level targets go to reaching envelope & performance targets

- configure a HTAP file (`air-tigtness-levels.run`)  that configures the 9.36 reference house with each of the prescribed air tightness levels.  
- Run evaluation across all 240 archetypes, in select locations 
- Evaluate % improvement relative to the reference house (both envelope, mechanical) achieved via air-tightness, compare to targets in each tier. Remember to consider which tier the home should be compared to. 

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

## HTAP Implementation
