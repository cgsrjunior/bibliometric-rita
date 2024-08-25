# 16 Years of Rita - A bibliometric analysis

## 1.Introduction

Rita is an brazilian scientific magazine that surges in 1989 with the mission to have a regular and strong computer science publication in the Informatics Institute - UFRGS. Since them, lots of changes have in article publication and RITA continues to carry his legacy across time. With a digital format of publication since 2008, having 16 years of article knowledge stored in database, creates a perfect opportunity to make an exploratory analysis to observe many different aspects of computer science publication inside the magazine.


In this study we try to answer the following questions:

* How the number of publications evolve across 15 years of existence and Which years had the highest and lowest number of publications?
* How do different bibliometric indexers vary in assessing the quality and impact of scientific publications in the journal over the last 15 years?
* Which subjects have more views across 15 years?
* Which articles have most views?
* Which authors and institutions have the highest number of published articles?
* What is the variation of the topics published in our magazine?
* What is the geographical distribution of the authors of the articles published in the journal?
* What is the collaboration network between authors and institutions in the journal's articles?
* Which authors and institutions are the ones with most articles rejected?
* How different was the keywords of the rejected articles compared to the accepted ones?
  

Basic description of each script

### rita-preprocessing.r

This script was used to remove unused data and incomplete rows from the dataset extracted received from RITA

### rita-scrapping.R

Used to gather additional information related to articles from RITA website - number of pages, DOI and authors

### rita-word-rechazados-versus-acceptados.r

Used to compare keywords from rejected submissions against accepted ones

### rita-vizualization-per-topic.R | rita-views-analysis.r

Used to group views to keywords in a way to check a popularity of some areas of study

### rita_relationships.r

Used to explore graph connections between authors and institutions by looking at their collaboration between studies

### make-tessarus.r

Gather a IEEE Tessarus .csv and converts them into a dictionary

### make-tessarus.r

Script used to count the volume of submissions based on their respective language

### make-tessarus.r

Used to generate graph and table of published and declined articles

### rita-bibliometrics-calc.r

Calculate bibliometric indexers defined in the experiment from 2008 to 2023

### rita-extract-rechazados.r

Script made to extract only rejected submissions from RITA dataset

### rita-get-coordinates-cities.r

Used to get coordinates based on the city name

### rita-geoloc.r

Script developed to gather latitude and longitude of each author and plot them on a map using leaflet

### rita-padronize.r | rita-subject-analysis.r

Created to compare keywords of areas and subareas of submission from a certain year in contrast to other years

### rita-viewmerge.r

Used to group view count information for each submission accepted
