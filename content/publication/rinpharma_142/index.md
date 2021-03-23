---
title: 'Interactive medical oversight reporting in R'
authors:
- Laure Cougnaud, Michela Pasetto
- Arne de Roeck
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

abstract: Medical oversight during a clinical trial is an extensive and time-consuming process. To safeguard patient safety, medical monitors need to review and explore raw safety data interactively, using standard visualizations as well as specific analyses tailored to the disease and the clinical study. The creation of semi-automated reports in R could facilitate this operation. The reports include interactive visualizations (with the plotly package) and interactive descriptive statistics tables and listings (with the DT package) for safety review of the patients. Template reports (based on Rmarkdown) incorporating standard analyses are integrated within an R package. The reports are set up via YAML configuration files to allow non-R users to customize the report for his/her specific study. Such report is created from datasets in CDISC standard SDTM or ADaM format, and delivered in the form of linked self-contained html pages. The creation of the report documentation (in the R package) and the validation of the input parameters in the config files is automated and provided with the JSON schema format. The medical oversight tool is integrated with functionalities to generate patient profiles, CSR-ready in-text tables, and enables comparison of results between multiple interim data batches delivered in the course of the clinical trial. The tool will be demonstrated on a publicly available dataset.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://medical-monitoring.openanalytics.io/slides/#1'
url_video: 'https://youtu.be/Aeu1_xCUVPQ'

---