---
title: 'Prediction of maternal-fetal exposures of CYP450-metabolized drugs using physiologic pharmacokinetic modeling implemented in R and mrgsolve'
authors:
- Madeleine S. Gastonguay
date: '2019-08-22T00:00:00Z'

# Schedule page publish date (NOT proceeding's date).
publishDate: '20001-01-01T00:00:00Z'

# proceeding type.
# Legend: 0 = Uncategorized; 1 = Talk, 2 = Keynote, 3 = Workshop
# To add more update publications_types.toml and en.yaml
publication_types: ['1']
publication_type_description: Talk

# proceeding name and optional abbreviated proceeding name.
publication: Presented at 2019 Conference
publication_short: Presented at 2019 Conference

abstract: Physiologically based pharmacokinetic (PBPK) models are used extensively in drug development to address of number of problems. However, most PBPK applications have limited knowledge sharing impact because they are implemented in closed, proprietary software. Much of the physiologic data and knowledge required for these models is publically available or available in the pre-competitive space. To this end, we've engaged in the development of open science PBPK models, using R as the scaffolding for this work. In particular, our group has developed the mrgsolve R package which utilizes Rcpp to compile models of systems of ordinary differential equations. One example is the development of a PBPK model to predict maternal/fetal exposures for drugs that are primarily metabolized by liver CYP450 enzymes throughout pregnancy. This model aims to utilize a quantitative understanding of the physiological and biochemical changes that occur throughout pregnancy to inform clinical pharmacology decisions where clinical trials cannot. The model was validated against the observed data of 5 different drugs midazolam, metoprolol, caffeine, nevirapine, and artemether. A series of local sensitivity analyses followed by parameter optimization further improved model predictions using the mrgsolve and nloptr R packages. The developed maternal-fetal PBPK model in its flexible open-source implementation provides a transparent, platform-independent, and reproducible system for model-informed decision support while developing exposure-based dosing recommendations in maternal/fetal patient populations.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://github.com/rinpharma/rinpharma2019program/tree/master/talks_folder/2019-Gastonguay-Prediction_of_maternal_fetal_exposures_of_CYP450_metabolized_drugs.pdf'
url_video: ''

---