## Trends of female authorship in head and neck surgery publications over the last decade

This repository contains reproducible code for our research manuscript titled `Trends of female authorship in head and neck surgery publications over the last decade`, which is published in the journal `Head & Neck`.

<strong>Full citation:</strong> Ferraro, T., Cole, J., Lee, S. M., Pershad, A. R., Lee, E., Hildebrand, H., ... & Thakkar, P. (2024). Trends of female authorship in head and neck surgery publications over the last decade. Head & Neck.

<strong>DOI:</strong> https://doi.org/10.1002/hed.27819
<br>  
<br>  

## Visual Abstract
![plot_first_author_senior](https://github.com/seanmlee/headneck_female_authorship/assets/82421211/c5faad3a-d8d5-47ad-bf98-96588b4c62cf)
<br>  
<br>  

![plot_funding](https://github.com/seanmlee/headneck_female_authorship/assets/82421211/166870c9-f7c1-4083-bde9-e5769190524c)
<br>  
<br>  

![plot_senior_author_impact](https://github.com/seanmlee/headneck_female_authorship/assets/82421211/fb84385c-4522-4059-9883-938d547b6b44)
<br>  
<br>  

## To use this repository

- Clone the repository and open the `./headneck_female_authorship.Rproj` R Project file
- This repository uses `renv` dependency management, so all software, package, and dependency version information is listed in the `./renv.lock` file and will automatically configure once prompted
- All scripts are in the `./scripts` directory
- Run the `./scripts/prep.R` script to load and format data
- Then run any of the `./scripts/mod_.R` scripts to fit the 3 models that we described in this study
- Each `./scripts/mod_.R` script will automatically output model prediction plots into the `./out` directory
  - You can also run each plot script manually using scripts in the `./scripts/plots` directory
<br>  
<br> 
