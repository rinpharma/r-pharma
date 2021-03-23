---
title: 'R Package Validation Framework'
authors:
- Ellis Hughes
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

abstract: In this talk I will discuss the steps that have been created for validating internally generated R packages at SCHARP (Statistical Center for HIV/AIDS Research and Prevention). Housed within Fred Hutch, SCHARP is an instrumental partner in the research and clinical trials surrounding HIV prevention and vaccine development. Part of SCHARP's work involves analyzing experimental biomarkers and endpoints which change as the experimental question, analysis methods, antigens measured, and assays evolve. Maintaining a validated code base that is rigid in its output format, but flexible enough to cater a variety of inputs with minimal custom coding has proven to be important for reproducibility and scalability. SCHARP has developed several key steps in the creation, validation, and documentation of R packages that take advantage of R's packaging functionality. First, the programming team works with leadership to define specifications and lay out a roadmap of the package at the functional level. Next, statistical programmers work together to develop the package, taking advantage of the rich R ecosystem of packages for development such as roxygen2, devtools, usethis, and testthat. Once the code has been developed, the package is validated to ensure it passes all specifications using a combination of testthat and rmarkdown. Finally, the package is made available for use across the team on live data. These procedures set up a framework for validating assay processing packages that furthers the ability of Fred Hutch to provide world-class support for our clinical trials.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://thebioengineer.github.io/validation_rpharma/'
url_video: 'https://youtu.be/zEH-6Ik-5h8'

---