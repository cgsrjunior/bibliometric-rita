# metadata-article-ml
This repository is going to host a project when we want to analysis article metadata to learn information about the authors, university, themes, articles accepted and rejected and anything regarding publications managed by R.I.T.A. (Revista de Informática Teórica e Aplicada - Journal of Theoretical and Applied Informatics)

# Data Gathered

The data used in this study are provided by Marcio Dorn, current chief-in-editorial at RITA. 

The data provided are allocated in two spreadsheets `BD_17_11_2023.csv` and `views-20231205.csv`, and could be summarized in two categories:
  *  The first one is a database with all data related to articles both accepted and rejected and with a bunch of complementary info
  *  The last one is a database related to articles approved and published in the magazine, showing metrics like number of views, publishing date and so on

# Extraction Process For The Analysis (`rita-preprocessing.r`)

1.  In the first phase we need to make a cleanup on the database to ensure that we didn't use incomplete information on our analysis
    *  We remove fields that didn't have any relevance to us in the research such as e-mail, homepages, urls and so on.
    *  After that we scan all the remaning data in search for blank/null values in important fields for the analysis and remove those entries in the database. Examples are title, abstract, country, et cetera.
    *  And in the end, we remove all types of separators and characters that will be a problem in the exporting process as a csv.

This will generate our first intermediare database, `BD_RITA01.csv`

2. After that we going to upload to google spreadsheet so we can padronize the language by using the Google Translation function on the abstract so we can use this for word analysis

After that we have a new intermediare database `BD_RITA02.csv`

# Gather aditional info using webscrapping (`rita-scrapping.R`)

1. We made a script to execute a webscrapping on RITA website to gather new info: author affiliation, institution, number of pages and year of publication

 salida=rbind (salida,data.frame(doc=datos$Submission.ID[a],authors=autores,
                                 institution=universidades,pages=num_paginas,year=ano,date=datos$Date.submitted[a]))

After that we have a new intermediare database `BD_RITA03.csv`

# Correlate information of published articles with visualization report (`rita-viewmerge.r`)

1. In this script we create the merge with `BD_RITA03.csv` and `views-20231205.csv` to have data about number of views per article on our database
   * This merge was made using the ID obtained in the webscrapping process and we use this to match with the ID column presented in the views table

After that we have a new intermediare database `BD_RITA04.csv`

# Padronize institutions names and adding the city location

Since we want to quantify how many institutions we have on database, we made a manual padronization of the university fields and create a Google App Script to insert the info related to city and country

These scripts are add as a macro in google spreadsheet and can be found in the tool in the menu Extensions -> Google App Script with names preencherCidade() and preencherCidades

After that we have a new intermediare database `BD_RITA05.csv`

# Geolocate institutions by gathering latitude and longitude (`rita-get-coordinate-cities.r`)

This script will check the name of every city and get the lat/long info using the lib `nominatimlite`

# Geolocate institutions by gathering latitude and longitude (`rita-geoloc.r`)

After that i rename `BD_RITA04.csv` to `BD_RITA06.csv` and use `BD_RITA05.csv` and `BD_RITA06.csv` to merge information and the lib tidyverse to use lat and long to put all the institutions on a OpenStreetMap
