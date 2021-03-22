---
title: 'The Use of R in the Development of Physiological Model for Healthy Growth'
authors:
- Rena J. Eudy-Byrne
date: '2018-08-15T00:00:00Z'

# Schedule page publish date (NOT proceeding's date).
publishDate: '20001-01-01T00:00:00Z'

# proceeding type.
# Legend: 0 = Uncategorized; 1 = Talk, 2 = Keynote, 3 = Workshop
# To add more update publications_types.toml and en.yaml
publication_types: ['1']
publication_type_description: Talk

# proceeding name and optional abbreviated proceeding name.
publication: Presented at 2018 Conference
publication_short: Presented at 2018 Conference

abstract: A physiologically-based mathematical model was developed as a series of ordinary differential equations to describe compositional changes (in fat and fat-free mass, FM & FFM) due to metabolizable energy exchanges in babies from birth to 2 years in low-to-middle income countries.1 The objective of this work was to identify potential biomarkers for future intervention studies, identify when to intervene to protect and/or rescue growth in individuals suffering from malnutrition, and to identify which of these individuals would be more or less likely to respond to a nutritional intervention. A translation of this model (155 parameters and 26 compartments) using R and the open-source mrgsolve package2 provided an efficient platform for multi-parameter optimization, as required during additional model development and for subsequent simulations. For comparison, a 8.62 seconds simulation with viral and bacterial infections (no interventions) in the R/mrgsolve implementation required 226 seconds in Matlab. Model translation to R also enabled simulations with a Shiny App, allowing users to simulate individual infant phenotypes and infection events and visualize growth and energy levels over time, relative to healthy (WHO) standards. The model currently also includes a relatively simple implementation of persistent antibiotic therapy with a potential for inclusion of drug exposure-related effects, i.e. - through a pharmacokinetic (PK) model, to describe effects of antiviral or antibiotic therapy. The challenge to this development is the scarcity of available data describing this therapy in malnourished children that would be needed for model calibration. Further development of the model includes linking to other systems models such Mother-fetus energy exchange or PBPK mother-fetus models, to enable simulations of growth beginning at gestation.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://github.com/rinpharma/2018_presentations/blob/master/talks_folder/2018-Byrne-Physiological_Model_for_Healthy_Growth.html'
url_video: ''

---