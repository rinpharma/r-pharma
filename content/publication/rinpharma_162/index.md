---
title: 'Clinical Reporting Using R at GSK'
authors:
- Michael Rimler
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

abstract: The development of laboratory developed tests (LDTs) and in vitro diagnostics (IVDs) requires the execution of studies to determine the analytical performance of the assay. Examples of analytical studies include limit of detection, intermediate precision, and stability studies. These studies often require similar analyses to be repeated multiple times on replicates or different sample types. The results of these analyses need to be stored in data structures that are easily accessible to the lead analyst as well as additional team members responsible for validating the work. Nested data frames are a powerful and flexible data structures that are well suited for these requirements. This talk will show how storing all of the steps of an analysis pipeline in a nested data frame allows analysts to utilize the well-established functionality of the tidyverse family of packages for efficient analysis and summarization of the data. It will also discuss how nested data frames are well suited for reproducibility and traceability, which are vital to documenting analytical performance. Reproducibility is often achieved by writing R notebooks in an environment that maintains package version consistency (e.g. docker, RStudio Server). Using nested data frames as the underlying data structure within these frameworks provides a transparent and modular method for storing the results of an existing analysis and providing easily accessible data for downstream analysis.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://github.com/rinpharma/2020_presentations/tree/master/talks_folder/2020-Rimler-Clinical_Reporting_GSK.pptx'
url_video: 'https://youtu.be/Z4JXMERYunc'

---