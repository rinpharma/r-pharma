---
title: 'Reproducible computation at scale in R with targets'
authors:
- Will Landau
date: '2020-10-15T00:00:00Z'

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

abstract: Data science can be slow. A single round of statistical computation can take several minutes, hours, or even days to complete. The targets R package keeps results up to date and reproducible while minimizing the number of expensive tasks that actually run. The targets package learns how your pipeline fits together, skips costly runtime for steps that are already up to date, runs the rest with optional implicit parallel computing, abstracts files as R objects, and shows tangible evidence that the output matches the underlying code and data. In other words, the package saves time while increasing our ability to trust the conclusions of the research. In addition, it surpasses the most burdensome permanent limitations of its predecessor, drake, to achieve greater efficiency and provide a safer, smoother, friendlier user experience. This talk debuts targets with an example COVID-19 clinical trial simulation study.

tags:
- Rstudio
featured: false

links:
url_slides: 'https://wlandau.github.io/rpharma2020/#1'
url_video: 'https://youtu.be/GRqKJBaC5g4'

---