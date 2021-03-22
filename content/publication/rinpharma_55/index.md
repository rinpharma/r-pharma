---
title: 'Enhance R Overview'
authors:
- Jay Timmerman
date: '2018-08-16T00:00:00Z'

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

abstract: Recruitment models for clinical trials are notoriously difficult to build due to many complex factors within a study. With input from experienced practitioners, we have built an interactive tool to allow individuals to build complex recruitment models using the R/Shiny framework. The Tool Enhance R, our platform for study modeling, was ported from an Excel-based tool to the R/Shiny platform to increase model development speed, expand capability and drive transparency into model development. The tool allows users to specify critical model attributes (i.e. country site distribution, recruitment/activation rates, country-specific vacations), and provide instantaneous feedback that changes have on a model’s probability of success. Using the RStudio Connect platform, we are able to grant multi-level access to users through a single web interface. Model development is tracked by exporting results to a SharePoint site and logging versions for future review/auditing. This gives significant levels of transparency on how a model was created and evolved over time. For web analytics, we used Piwik, and internal web analytics platform, to monitor how users navigate through the platform and identify browsing behavior. The application was built upon the Shiny Dashboard framework and leverages many visualization packages, including Plotly, Timevis, ggplot2 and many more. Many challenges arose in its develop, from controlling over-zealous user clicks causing out of control execution, to integrating service account execution of apps to facilitate centralized data control. This project pushed the limits of what the R/Shiny platform is capable of and demonstrates how data scientists can build useful solutions.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://github.com/rinpharma/2018_presentations/blob/master/talks_folder/2018-Timmerman-Enhance_R.pptx'
url_video: ''

---