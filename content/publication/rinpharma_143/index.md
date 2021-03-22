---
title: 'Implementing Mixed Models with Repeated Measures (MMRM) in R and Shiny for Regulatory Purposes'
authors:
- Daniel Sabanés Bové
date: '2020-10-13T00:00:00Z'

# Schedule page publish date (NOT proceeding's date).
publishDate: '20001-01-01T00:00:00Z'

# proceeding type.
# Legend: 0 = Uncategorized; 1 = Talk, 2 = Keynote, 3 = Workshop
# To add more update publications_types.toml and en.yaml
publication_types: ['1']
publication_type_description: Talk

# proceeding name and optional abbreviated proceeding name.
publication: Presented at 2020 Conference
publication_short: Presented at 2020 Conference

abstract: MMRMs are often used as the primary analysis of continuous endpoints in longitudinal clinical trials (see e.g. Mallinckrod et al, 2008). Essentially, an MMRM is a specific linear mixed effects model that includes (at least) an interaction of treatment arm and categorical visit variables as fixed effects. The covariance structure of the residuals can have different forms, and often an unstructured (i.e. saturated parametrization) covariance matrix is preferred. This structure can be represented by random effects in the mixed model. All of this has typically been implemented in proprietary software, such as SAS, as its PROC MIXED routine is generally seen as a gold standard for mixed models. However, this does not allow the use of interactive web applications to explore the clinical study data in a flexible way. Furthermore, fitting such proprietary software into workflows such as automatic document generation is not convenient. Therefore, we wanted to implement MMRM in R. Several challenges had to be solved, such as finding the right R-packages for this purpose. We finally settled on {lme4} in combination with {lmerTest}, which could match results in SAS up to numerical precision. Convergence of estimates can be an issue and multiple optimization algorithms are therefore tried in parallel to enhance robustness. Extracting the covariance matrix estimate from {lme4} results was solved as well as finding model fit statistics that match SAS results. We use our own {rtables} to produce tables and {ggplot2} for plots. We developed a Shiny module in our internal framework for exploratory web applications. Further validation in the next months will allow us to use the R implementation for regulatory purposes, with greater flexibility and efficiency than before.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://github.com/rinpharma/2020_presentations/tree/master/talks_folder/2020-Sabanes_Bove-Implementing_MMRM_in_R.pdf'
url_video: 'https://youtu.be/moEksA8gHoY'

---