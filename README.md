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
