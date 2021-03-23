---
title: 'Improve installation sequences for R package cohorts'
authors:
- Juliane Manitz
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

abstract: The installation of a cohort of R packages can constitute a challenge; especially considering different dependency types, package versions, overlapping namespaces and varying risks assigned to each of the packages. At the same time, the number of R packages to be installed grows exponentially with each new package added. Their complex dependencies may create conflicts. In this context, the R admin is often confronted with a cohort of packages without knowing the package of interest. We use statistical analysis techniques from the field of complex network analysis in order to shed light into the non-trivial dependency structures of package cohorts. Furthermore, we simplify the network graph to find improved installation sequences for a pre-selected cohorts of R packages. We reduce large package cohorts to a sufficient shortlist of packages, whose installation automatically pulls in other packages via dependencies without causing conflicts. The build time of a library may be greatly reduced. As a byproduct, we generate a graph of the build on the exact dependency tree and actual versions used for auditing and change control in the regulated workflows. This strategy also allows for the identification of high-risk packages and their importance in the dependency tree.

tags:
- Rstudio
featured: false

links:
url_slides: ''
url_video: ''

---