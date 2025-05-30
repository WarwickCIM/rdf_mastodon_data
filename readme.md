[![](https://img.shields.io/badge/DOI-10.17605/OSF.IO/734YW-blue)](https://doi.org/10.17605/OSF.IO/734YW)

# Survey dataset on the motivations, experiences and expectations of Mastodon users

This repository contains different components derived from a Survey released between 13th January 2023 and 13th April 2023 aimed at understanding peoples' motivations to join Mastodon as well as their current experience and future usage:

1.  Anonymised Dataset with the survey responses. The dataset is a `csv` file containing 820 responses and 107 variables.
2.  Dataset Metadata, generated with [dataspice](https://docs.ropensci.org/dataspice/) and stored in a human-readable companion website (<https://warwickcim.github.io/rdf_mastodon_data/>) and a machine-readable JSON file (<https://osf.io/efm7j>).
3.  Scripts used to generate the resulting dataset after cleaning and anonymising the raw data from qualtrics (not included).
4.  PDF copies of the original survey

You are free to reuse this dataset under the Licence conditions. If you use this dataset in your work, please cite it as below:

> Cámara-Menoyo, C. (2023). Survey dataset on the motivations, experiences and expectations of Mastodon users (Version 0.0.1) [Dataset]. <https://doi.org/10.17605/OSF.IO/734YW>

For your convenience, we have also included a `CITATION.bib` file you may want to use to import it to your Reference Manager.

``` bibtex
@dataset{Camara-Menoyo_Mastodon_survey_2023,
  title = {The {{Cyber Expertise Diversity Survey Dataset}}},
  author = {{C{\'a}mara-Menoyo}, Carlos},
  year = {2023},
  publisher = {https://github.com/WarwickCIM/rdf_mastodon_data},
  doi = {10.17605/OSF.IO/734YW},
  langid = {english}
}
```

## About us

This is an output of [*Researching Platform Migration: Twitter Decline and the Rise of Mastodon*](https://osf.io/ex8q6/), funded by the [University of Warwick](https://warwick.ac.uk/)'s Research Development Fund 2022/23 (Ref:HSSREC 95/22-23), led by Carlos Cámara-Menoyo (PI) and Nathaniel Tkacz (Co-I)

Other CIM staff involved in putting the survey together and analysing the data Nathaniel Tkacz and Fangzhou Zhang.

## Installation

If you just want to use the data, there's no need to install anything. You can navigate through the files within `data/` folder and download them from there, or from the public website.

If you are interested in running the code to replicate this repo, you will need to:

1.  Clone this repo `git clone git@github.com:WarwickCIM/cyberexpertisediversity_survey_data.git`
2.  Install dependencies running `renv::restore()`

## 
