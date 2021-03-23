---
title: 'openNCA Pharmacokinetic data repository and Non-compartmental Analysis System'
authors:
- Thomas Tensfeldt
date: '2020-10-14T00:00:00Z'

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

abstract: Non-compartmental pharmacokinetic analysis (NCA) is used in the characteristization of drugs absorption, distribution and elimination in the body. Software that implements NCA is available from commercial and non-commercial, open-source, sources. openNCA is a Pfizer, Inc in-house developed desktop application with enterprise capabilities designed to provide a PK bioanalysis result repository as well as an NCA computation routines. The system is built with modern technologies including Javascript/Typescript, Angular, Electron, Elasticsearch, Modeshape, Splunk, docker and a substantial R code base that implements system functions, configuration, analysis, reporting and user defined functionality. openNCA capabilities include -Repository/Library/Metadata stores -Data Loading/Merging/Validation -Integration with Clinical Trial operational data -Integration with Patient Information Management System -Data Access controls -Data Transformation -NCA Analysis -RMarkdown and LaTeX Reporting -Shiny Apps -Quality Control -Workflow, Data, Transformation and Analysis Lineage -Navigation and Search -Reporting Event management -Publishing/Data Sharing Design considerations for openNCA include reproducibility, security/integrity, extensibility, discoverability and traceability. Extensibility is a cornerstone characteristic that is enabled through extensive utilization of the application of R scripts and Shiny apps to configure the system functions. The openNCA computation engine R package (https//github.com/tensfeldt/openNCA) for NCA analyses enables some unique capabilities and forms one module of the system and is open-sourced under the MIT license. openNCA, both the R driven application and NCA computation R package, provides an example of an industrial application of R and is represents the in-kind contribution from Pfizer Inc to the intial prototype project of the Pharmaceutical Open Source Software Consortium (POSSC https//www.possc.org/) to promote industrial support for open-source software development and innovation for the Clinical Pharmacology and Pharmacometrics discipline.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://github.com/rinpharma/2020_presentations/tree/master/talks_folder/2020-Tensfeldt-OpenNCA.pptx'
url_video: 'https://youtu.be/Dw6HrBUdcmU'

---