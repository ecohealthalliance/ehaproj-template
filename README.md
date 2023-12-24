
<!-- README.md is generated from README.Rmd. Please edit that file -->

# *mkrproj*

<!-- Standard badges and licenses: -->
<!-- [![DOI](https://zenodo.org/badge/DOI/[ZENODO_DOI])](https://doi.org/[ZENODO_DOI]) Uncomment when deposited to Zenodo -->

[![License (for code):
MIT](https://img.shields.io/badge/License%20(for%20code)-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![License (for data):
CC0-1.0](https://img.shields.io/badge/License%20(for%20data)-CC0_1.0-lightgrey.svg)](http://creativecommons.org/publicdomain/zero/1.0/)
[![License (for text):
CC-BY-4.0](https://img.shields.io/badge/License%20(for%20text)-CC_BY_4.0-blue.svg)](http://creativecommons.org/publicdomain/zero/1.0/)

<!-- If the repository is or will be related to a manuscript, keep the following
text. Otherwise replace it with a high-level summary and relevant citation,
contact, or re-use information. -->

This repository contains data and R code which are supplements to:

*Paper Title*, by Author
[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/AUTHOR_ORCID_ID),
Author
[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/AUTHOR_ORCID_ID),
and Author
[![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/AUTHOR_ORCID_ID),
(20XX)

Please cite that paper, when referring to this work. Please also cite
the permanent archive of repository (Zenodo reference
(<https://doi.org/%5BZENODO_DOI%5D>) when reusing or referring directly
to data and code.

## Repository Structure and Reproducibility

<!-- Modify this appropriate if you change project structure -->

- `data/` contains data from the study and a data dictionary describing
  all variables.
- `R/` contains functions used in this analysis.
- `reports/` contains R Markdown/Quarto reports generated in the
  analysis
- `outputs/` contains figures and other outputs
- This project uses the
  [{targets}](https://wlandau.github.io/targets-manual/) framework to
  organize build steps for analysis pipeline. The steps are defined in
  the `_targets.R` file and the workflow can be executed by running
  `run.R` via `source("run.R")` in your R terminal or `Rscript run.R` in
  your system shell. The schematic figure below summarizes the steps.
  (The figure is generated using `mermaid.js` syntax and should display
  as a graph on GitHub. It can also be viewed by pasting the code into
  <https://mermaid.live>.)

<script type="module">
  import mermaid from 'https://unpkg.com/mermaid@9/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>

``` mermaid
graph LR
subgraph Project Workflow
    direction LR
    x835f456db5951df5(["all_plot_files"]):::skipped --> xbda0fd67e19f73bc(["outputs_readme"]):::built
    x07b56d1fbca21cf3(["summarized_quantities"]):::skipped --> xbda0fd67e19f73bc(["outputs_readme"]):::built
    x9e3eef4eeb77d655(["report_template"]):::skipped --> x9e3eef4eeb77d655(["report_template"]):::skipped
  end
linkStyle 0 stroke-width:0px;
```

- This project was built with R version 4.2.2 (2022-10-31). This project
  uses the [{renv}](https://rstudio.github.io/renv/) framework to record
  R package dependencies and versions. Packages and versions used are
  recorded in `renv.lock` and code used to manage dependencies is in
  `renv/` and other files in the root project directory. On starting an
  R session in the working directory, run `renv::restore()` to install R
  package dependencies.

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
