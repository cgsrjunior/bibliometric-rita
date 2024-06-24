<title># 16 Years of Rita - A bibliometric analysis</title>

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
  

## 2. Background and related work

This chapter introduces a fundamental explanation of bibliometrics and its metrics, methods, and applications. After that, we discuss the related work, their contributions, and their limitations.

### 2.1 - Bibliometric overview

Bibliometric analysis is a popular and rigorous method for exploring and analyzing large volumes of scientific
data. It enables us to unpack the evolutionary nuances of a specific field, while shedding light on the emerging areas in that field (Donthu et al., 2021)

For the usage of bibliometric toolbox, we need to met two conditions:

  * The scope of the review is too broad (Donthu et al., 2021)
  * Dataset is too large for a manual review (Donthu et al., 2021)
  
RITA has publication records from 2008 to 2023, and we want to use that dataset to evaluate scientific production, research tendencies, and collaborations related to authors who contributed to the journal.

### 2.2 - Main techniques

Bibliometric analysis consists of two main techniques: Science Mapping and Performance Analysis

Performance analysis examines the contributions of research constituents to a given field (Cobo, López-Herrera, Herrera-Viedma, & Herrera, 2011; Ramos-Rodrígue & Ruíz-Navarro, 2004)

Science mapping examines the relationships between research constituents (Baker, Kumar, & Pandey, 2021; Cobo et al., 2011; Ramos-Rodrígue & Ruíz-Navarro, 2004).

The image below gave us an overview of the metrics presented in this study:

![Table with metric description (Donthu et al., 2021)](C:/Users/ntu_c/metadata-article-ml/rpubs-images/toolbox_metrics_overview.png)

The main goal of bibliometric analysis is to use quantitative methods so we can observe patterns presented in the database to identify tendencies, frequency, interations, anything related to authors and articles that've submit to the journal across the years.

Other methods can be used to evaluate article production, such as Systematic Literature Review or Meta-Analysis. The first is used to summarize and synthesize the findings of existing literature on a research topic or field, while the other summarize the empirical evidence of relationship between variables while uncovering relationships not studied in existing studies (Donthu et al., 2021).

Since the objective is to explore a large dataset of publications of many different topics and aspects of computer science, while observe the evolution of information related to articles and authors, this study opted for the usage of bibliometrical analysis
    
# 3. - Pipeline architecture overview

The following image below are the graphical representation to describe the pipeline defined in this proccess:
![Pipeline for processing RITA dataset](C:/Users/ntu_c/metadata-article-ml/rpubs-images/Diagrama_TCC_RITA.png)

A briefly overview of each step:

1. The extraction of dataset contain all the information presented in RITA are made and first we made a cleanup of all fields not used for any type of analysis and related to missing data presented in the columns
2. We padronize the text language generating translation of abstracts to english for purposes of word frequency and analysis
  After that we partition the dataset into two different datasets to avoid merging problems between different types of articles:
  2.1. One dataset of published articles - to allow summarizing views and bibliometric indexes calculations
  2.2. Another dataset of rejected articles - to explore more aspects on the side of articles that didn't have seen the light of day
3. Run macros to padronize name of institutions and with basis on this info, locate city and country respective
4. Using the package of nominatimlite to gather latitude and longitude based on the city where the institutions are located
5. Merging views information with the published articles dataset
6. Editing with Google Sheets to merge the remaining data related to title, abstract and submission date 
7. A script was created to scrapping IEEE Tessaro and transform them into a dictionary to be used to padronize tokens into keywords and then subsequently used on the word analysis 

# 4. - The Results

### 4.1 How the number of publications evolve across 15 years of existence and Which years had the highest and lowest number of publications?

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/publications_year.html" width="100%" height="500"></iframe>

#### Looking only for accepted and rejected results

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/pub_year_accept_declined.html" width="100%" height="500"></iframe>

| Year | Total articles | Published | Declined |
|:----:|:--------------:|:---------:|:--------:|
| 2008 |       48       |    41     |    7     |
| 2009 |       66       |    28     |    38    |
| 2010 |       69       |    38     |    31    |
| 2011 |       48       |    10     |    38    |
| 2012 |       76       |    20     |    56    |
| 2013 |       48       |    14     |    34    |
| 2014 |       56       |    13     |    43    |
| 2015 |       67       |    20     |    47    |
| 2016 |       54       |     9     |    45    |
| 2017 |       61       |    18     |    43    |
| 2018 |      114       |    30     |    84    |
| 2019 |       68       |    24     |    44    |
| 2020 |       48       |    22     |    26    |
| 2021 |       50       |    15     |    35    |
| 2022 |       44       |    13     |    31    |
| 2023 |       36       |     4     |    32    |

#### Total of articles received classified by language

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_submissions_aggregated_language.html" width="100%" height="500"></iframe>

| Year | Total articles | en_US | es_ES | pt_BR | pt_PT |
|:----:|:--------------:|:-----:|:-----:|:-----:|:-----:|
| 2008 |       48       |   0   |   0   |  48   |   0   |
| 2009 |       66       |   0   |   0   |  66   |   0   |
| 2010 |       69       |   0   |   0   |  69   |   0   |
| 2011 |       48       |   0   |   0   |  48   |   0   |
| 2012 |       76       |   0   |   0   |  76   |   0   |
| 2013 |       48       |   4   |   0   |  44   |   0   |
| 2014 |       56       |  14   |   1   |  40   |   1   |
| 2015 |       67       |   6   |   0   |  61   |   0   |
| 2016 |       54       |   4   |   0   |  49   |   1   |
| 2017 |       61       |  13   |   0   |  47   |   1   |
| 2018 |      114       |  101  |   0   |  13   |   0   |
| 2019 |       68       |  68   |   0   |   0   |   0   |
| 2020 |       48       |  48   |   0   |   0   |   0   |
| 2021 |       50       |  50   |   0   |   0   |   0   |
| 2022 |       44       |  44   |   0   |   0   |   0   |
| 2023 |       53       |  53   |   0   |   0   |   0   |

Since we have a lower number of articles published related to 2023, we attained to use data until 2022 for some analysis to ensure that we have the significant large scope of dataset for each year

### 4.2 How do different bibliometric indexers vary in assessing the quality and impact of scientific publications in the journal over the last 15 years?

### 4.2.1 Indexers related to publications

These indicators included in (Gupta and Hasan 2018) measure the relationship between the number of authors and the number of publications.

#### a. Annual Growth Rate of Publications - ARG

This indicator measures the percentage change in the number of articles between years (Gupta and Hasan 2018). To calculate AGR, the formula used below:

\[
ARG = (\frac{\#\text{Manuscripts_year}[a] - \#\text{Manuscripts_year}[a - 1]}{\#\text{Manuscripts_year}[a]} \times 100)
\]

#### b. Cumulative Annual Growth Rate - CAGR

It corresponds to the cumulative growth rate of the number of publications over a specific period of time (Kulkanjanapiban and Silwattananusarn 2021). It is calculated as:

\[
\text{CAGR} = \left( \frac{\#\text{Manuscripts_year}_{\text{CUM}}[a]^{\left(\frac{1}{\text{year}(a) - 1}\right)}}{\#\text{Manuscripts_year}[a]} \right) \times 100
\]

#### c. Relative Growth Rate - RGR

It corresponds to the increase in the number of articles published per unit of time (Kumar and Kaliyaperumal 2015) (Rathika and Thanuskodi 2021). The average RGR for a time interval can be calculated using:

\[
\text{RGR} = \frac{\ln(\#\text{Manuscripts_year}[a]) - \ln(\#\text{Manuscripts_year}[a-1])}{\text{year}(a) - \text{year}(a-1)}
\]

#### d. Doubling Time - DT

There is a direct relationship between RGR and the time it would take for the number of publications to double. To calculate the doubling time (DT), a standard natural logarithm of 0.693 (Kumar and Kaliyaperumal 2015) is used here (Rathika and Thanuskodi 2021), applying the following equation:

\[
\text{DT} = \frac{0.693}{\text{RGR}}
\]

| Years | Freq | Freq_AC |    AGR |   CARG |  RGR |    DT |
|:------|-----:|--------:|-------:|-------:|-----:|------:|
| 2008  |   94 |      94 |   0.00 |   0.00 | 0.00 |  0.00 |
| 2009  |  101 |     195 |   7.45 |  93.07 | 0.73 |  0.83 |
| 2010  |   64 |     259 | -36.63 | 101.17 | 0.28 |  2.15 |
| 2011  |   30 |     289 | -53.12 | 112.78 | 0.11 |  5.48 |
| 2012  |   60 |     349 | 100.00 |  55.30 | 0.19 |  3.17 |
| 2013  |   33 |     382 | -45.00 |  63.20 | 0.09 |  6.70 |
| 2014  |   40 |     422 |  21.21 |  48.10 | 0.10 |  6.03 |
| 2015  |   60 |     482 |  50.00 |  34.67 | 0.13 |  4.64 |
| 2016  |   32 |     514 | -46.67 |  41.49 | 0.06 | 10.05 |
| 2017  |   50 |     564 |  56.25 |  30.90 | 0.09 |  6.70 |
| 2018  |   90 |     654 |  80.00 |  21.94 | 0.15 |  4.02 |
| 2019  |   75 |     729 | -16.67 |  22.97 | 0.11 |  5.48 |
| 2020  |   45 |     774 | -40.00 |  26.75 | 0.06 | 10.05 |
| 2021  |   39 |     813 | -13.33 |  26.32 | 0.05 | 12.06 |
| 2022  |   41 |     854 |   5.13 |  24.22 | 0.05 | 12.06 |
| 2023  |   18 |     872 | -56.10 |  29.52 | 0.02 | 30.15 |

### 4.2.2 Indexes related to the authors

#### a. Author productivity - AAPP and PPAA

These indicators included in (Gupta and Hasan 2018) measure the relationship between the number of authors and the number of publications.

\[
\text{AAPP} = \frac{\#\text{Authors_year[a]}}{\#\text{Manuscripts_year}[a]}
\]

\[
\text{PPAA} = \frac{\#\text{Manuscripts_year}[a]}{\#\text{Authors_year[a]}}
\]

#### b. Degree of Collaboration - DC

It is defined as the relationship between articles with more than one author (Nm) and those written by only one person (Ns) (Savanur and Srikanth 2009) (Gupta and Hasan 2018) (Barik and Jena 2019) (Das, Kaur, and Verma 2021).

\[
\text{DC} = \frac{N_{m}}{N_{m} + N_{s}}
\]

#### c. Collaborative Index - CI

It is a weighted average of authors per joint article. That is, those who have more than one author (Savanur and Srikanth 2009) (Gupta and Hasan 2018) (Barik and Jena 2019) (Das, Kaur, and Verma 2021)

\[
\text{CI} = \frac{\sum_{j=1}^{A} j * f_{j}}{N}
\]

#### d. Collaborative Coefficient - CC

It is a weighted average of authors per joint article. That is, those who have more than one author (Savanur and Srikanth 2009) (Gupta and Hasan 2018) (Barik and Jena 2019) (Das, Kaur, and Verma 2021).

\[
\text{CC} = 1 - \frac{\sum_{j=1}^{A} \frac{1}{j} * f_{j}}{N}
\]

Where:

* j is the number of authors per article, example: 1, 2, 3, …A
* fj is the number of articles with j authors.
* N is the total number of articles published in that year.

#### e. Modified Collaboration Coefficient - MCC

This indicator is applied and described in (Das, Kaur, and Verma 2021).

\[
\text{MCC} = (\frac{N}{N-1})(\frac{\sum_{j=1}^{A} \frac{1}{j} * f_{j}}{N})
\]

Where:

* j is the number of authors per article, example: 1, 2, 3, …A
* fj is the number of articles with j authors.
* N is the total number of articles published in that year.

#### f. Average number of pages per article (PNA)

Corresponds to the average number of pages per published article.

\[
\text{PNA} = \frac{\sum \text{#Number_pages}} {\text{#Manuscript_by_year}}
\]

|Years | Freq| AAPP| PPAA|   DC|   CI|   CC|  MCC|   PNA|
|:-----|----:|----:|----:|----:|----:|----:|----:|-----:|
|2008  |   94| 2.10| 0.48| 0.76| 2.29| 0.45| 0.46| 19.35|
|2009  |  101| 3.46| 0.29| 1.00| 3.61| 0.68| 0.71| 20.53|
|2010  |   64| 2.86| 0.35| 0.77| 2.91| 0.52| 0.54| 14.02|
|2011  |   30| 3.00| 0.33| 0.80| 3.00| 0.54| 0.60| 19.33|
|2012  |   60| 2.85| 0.35| 0.95| 3.00| 0.62| 0.66| 23.82|
|2013  |   33| 2.29| 0.44| 0.79| 2.36| 0.48| 0.52| 21.30|
|2014  |   40| 3.08| 0.32| 0.92| 3.08| 0.61| 0.66| 20.75|
|2015  |   60| 2.95| 0.34| 0.85| 3.00| 0.57| 0.60| 25.12|
|2016  |   32| 3.56| 0.28| 1.00| 3.56| 0.67| 0.75| 22.66|
|2017  |   50| 2.78| 0.36| 0.83| 2.78| 0.54| 0.57| 14.70|
|2018  |   90| 3.00| 0.33| 0.90| 3.10| 0.59| 0.61| 13.28|
|2019  |   75| 3.08| 0.32| 0.75| 3.12| 0.52| 0.54| 11.87|
|2020  |   45| 2.65| 0.38| 0.88| 2.65| 0.54| 0.58| 13.91|
|2021  |   39| 2.92| 0.34| 0.85| 3.00| 0.56| 0.61| 14.67|
|2022  |   41| 3.08| 0.32| 0.85| 3.15| 0.59| 0.64| 10.95|
|2023  |   18| 4.25| 0.24| 1.00| 4.50| 0.77| 1.02| 12.22|

### 4.2.3 Hipotesis proof for average of the indexes

We realize an statistical hipotesis test to see if our sample is significant enough. All tests realized in this section was using a confidence interval of 95% and p-value of 1. The results of each average are in the images down below

#### Average number of publications

![T Test of publications](C:/Users/ntu_c/metadata-article-ml/rpubs-images/t-test_publications_year.png)
![Standard Deviation](C:/Users/ntu_c/metadata-article-ml/rpubs-images/standard_deviation_publications_per_year.png)

#### Average number of pages

![T Test of pages](C:/Users/ntu_c/metadata-article-ml/rpubs-images/t-test_pages_publications.png)
![Standard Deviation](C:/Users/ntu_c/metadata-article-ml/rpubs-images/standard_deviation_pages_publications.png)

### 4.3 Which subjects have more views across 15 years?

#### Views per year 2022

![Views aggregated by Area in 2022](C:/Users/ntu_c/metadata-article-ml/rpubs-images/views_areas_2022.png)

|               area               | views |
|:--------------------------------:|:-----:|
|             Business             | 4239  |
|        Electric variables        | 3444  |
|     Artificial intelligence      | 2104  |
|         Computer science         | 1430  |
|    Computational linguistics     |  369  |
|            Algorithms            |  288  |
| Materials science and technology |  267  |
|             Circuits             |  260  |
|             Modeling             |  260  |
|         Medical services         |  214  |


#### Views per year 2018

![Views aggregated by Area in 2018](C:/Users/ntu_c/metadata-article-ml/rpubs-images/views_areas_2018.png)

|        area         | views |
|:-------------------:|:-----:|
|      Economics      | 64704 |
|  Computer science   | 44143 |
|     Industries      | 24660 |
|      Business       | 23400 |
|       Optics        | 19674 |
| Electric variables  | 16364 |
|      Modeling       | 6572  |
| Pattern recognition | 4182  |
|       Metals        | 3852  |
|     Algorithms      | 3301  |


#### Views per year 2013

![Views aggregated by Area in 2013](C:/Users/ntu_c/metadata-article-ml/rpubs-images/views_areas_2013.png)

|               area               | views |
|:--------------------------------:|:-----:|
|         Computer science         | 40964 |
|        Electric variables        | 21870 |
|            Economics             | 19008 |
|            Industries            | 13080 |
|    System analysis and design    | 4232  |
|           Optimization           | 1842  |
|             Modeling             | 1738  |
| Materials science and technology |  872  |
|         Image processing         |  869  |
|            Materials             |   0   |


#### Views per year 2008

![Views aggregated by Area in 2008](C:/Users/ntu_c/metadata-article-ml/rpubs-images/views_areas_2008.png)

|               area               | views  |
|:--------------------------------:|:------:|
|     Artificial intelligence      | 430288 |
|        Electric variables        | 110438 |
|              Robots              | 101007 |
|        Design methodology        | 86295  |
|            Industries            | 72905  |
|         Computer science         | 44352  |
| Materials science and technology | 11124  |
|       Information systems        | 10980  |
|             Modeling             |  9779  |
|           Probability            |  9225  |

### 4.4 Which articles have most views?

#### The 10 articles with the most views

|author                        |title                                                                                                                  |institution                                       | Views| year|
|:-----------------------------|:----------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------|-----:|----:|
|André C. P. L. F. de Carvalho |Uma Introdução às Support Vector Machines                                                                              |Universidade de São Paulo - USP                   | 51663| 2008|
|Maurício Marengoni            |Tutorial: Introdução à Visão Computacional usando OpenCV                                                               |Universidade Presbiteriana Mackenzie              | 27564| 2009|
|Adriana Bordini               |QEDS: Um Simulador Clássico para Distinção de Elementos Quântico                                                       |Universidade Federal de Pelotas - UFPel           | 25779| 2016|
|Lino Sanabria                 |Estudo do Padrão Avançado de Criptografia AES – Advanced Encryption Standard                                           |Universidade Federal da Grande Dourados - UFGD    | 13048| 2011|
|Paulo Blauth Menezes          |Teorias da Aleatoriedade                                                                                               |Universidade Federal do Rio Grande do Sul - UFRGS |  9708| 2008|
|Rafael Prikladnicki           |Um Olhar Sociotécnico sobre a Engenharia de Software                                                                   |Universidade Federal do Rio de Janeiro - UFRJ     |  9613| 2008|
|Jacques Wainer                |Processos de Decisão de Markov: um tutorial                                                                            |Universidade Estadual de Campinas - Unicamp       |  9516| 2008|
|Siome Klein Goldenstein       |A Gentle Introduction to Predictive Filters                                                                            |Universidade Estadual de Campinas - Unicamp       |  9225| 2008|
|Rafael Santos                 |Java Advanced Imaging API: A Tutorial                                                                                  |Instituto de Estudos Avançados – IEAv             |  8010| 2008|
|Heimar de Fátima Marin        |Desenvolvimento e Avaliação de um Protocolo Eletrônico para Atendimento e Monitoramento do Paciente com Doença Celíaca |Universidade Federal de São Paulo - UNIFESP       |  5946| 2010|

### 4.5 Which authors and institutions have the highest number of published articles?

#### Authors who published the most articles - Added until 2023

|Autores                          |Institution                                       | Frec|
|:--------------------------------|:-------------------------------------------------|----:|
|Anderson Faustino da Silva       |Universidade Estadual de Maringá - UEM            |    6|
|José Palazzo Moreira de Oliveira |Universidade Federal do Rio Grande do Sul - UFRGS |    6|
|Aldo von Wangenheim              |Universidade Federal de Santa Catarina - UFSC     |    4|
|Eanes Torres Pereira             |Universidade Federal de Campina Grande - UFCG     |    4|
|Luciano Antonio Digiampietri     |Universidade de São Paulo - USP                   |    4|
|Alfredo Silveira Araújo Neto     |Techway Informática Ltda                          |    3|
|Gustavo Rau de Almeida Callou    |Universidade Federal Rural de Pernambuco - UFRPE  |    3|
|Ivan Torres Pisa                 |Universidade Federal de São Paulo - UNIFESP       |    3|
|Jaime Simão Sichman              |Universidade de São Paulo - USP                   |    3|
|Judith Kelner                    |Universidade Federal de Pernambuco - UFPE         |    3|


### Institutions that published the most articles - Added until 2023

|Instituciones                                      | Frec|
|:--------------------------------------------------|----:|
|Universidade de São Paulo - USP                    |   75|
|Universidade Federal do Rio Grande do Sul - UFRGS  |   59|
|Universidade Federal de Pernambuco - UFPE          |   46|
|Universidade Federal de Pelotas - UFPel            |   34|
|Universidade do Estado de Santa Catarina - UDESC   |   27|
|Universidade Estadual de Campinas - Unicamp        |   26|
|Universidade Federal Rural de Pernambuco - UFRPE   |   25|
|Universidade Federal de Santa Catarina - UFSC      |   24|
|Universidade Tecnológica Federal do Paraná – UTFPR |   24|
|Universidade Federal de Juiz de Fora - UFJF        |   22|
    

### 4.6 What is the variation of the topics published in our magazine?

#### Areas and sub-areas of research observed in 2023

![Areas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/areas_study_2023.png)
![Subareas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/subareas_study_2023.png)

#### Areas and sub-areas of research observed in 2018

![Areas of study - 2018](C:/Users/ntu_c/metadata-article-ml/rpubs-images/areas_study_2018.png)
![Subareas of study - 2018](C:/Users/ntu_c/metadata-article-ml/rpubs-images/subareas_study_2018.png)

#### Areas and sub-areas of research observed in 2013

![Areas of study - 2013](C:/Users/ntu_c/metadata-article-ml/rpubs-images/areas_study_2013.png)
![Subareas of study - 2013](C:/Users/ntu_c/metadata-article-ml/rpubs-images/subareas_study_2013.png)

#### Areas and sub-areas of research observed in 2008

![Areas of study - 2008](C:/Users/ntu_c/metadata-article-ml/rpubs-images/areas_study_2008.png)
![Subareas of study - 2008](C:/Users/ntu_c/metadata-article-ml/rpubs-images/subareas_study_2008.png)

### 4.7 What is the geographical distribution of the authors of the articles published in the journal?

### Map with aggregated localization of authors

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/graph_total_aggregated_authors_location.html" width="100%" height="500"></iframe>

### Authors localized in 2023

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/graph_authors_location_2023.html" width="100%" height="500"></iframe>

### Total authors location in 2018

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/graph_authors_location_2018.html" width="100%" height="500"></iframe>

### Total authors location in 2013

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/graph_authors_location_2013.html" width="100%" height="500"></iframe>

### Total authors location in 2008

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/graph_authors_location_2008.html" width="100%" height="500"></iframe>

### 4.8 What is the collaboration network between authors and institutions in the journal's articles?

#### Aggregated connections of institutions across 15 years of RITA

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_aggregated_institutions_connections.html" width="100%" height="500"></iframe>

#### Relations between authors and institutions in 2008

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_authors_connections_2008.html" width="100%" height="500"></iframe>
<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_institution_connections_2008.html" width="100%" height="500"></iframe>

#### Relations between authors and institutions in 2013

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_authors_connections_2013.html" width="100%" height="500"></iframe>
<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_institution_connections_2013.html" width="100%" height="500"></iframe>

#### Relations between authors and institutions in 2018

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_authors_connections_2018.html" width="100%" height="500"></iframe>
<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_institution_connections_2018.html" width="100%" height="500"></iframe>

#### Relations between authors and institutions in 2023

<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_authors_connections_2023.html" width="100%" height="500"></iframe>
<iframe src="C:/Users/ntu_c/metadata-article-ml/rpubs-interactive-graph/total_institution_connections_2023.html" width="100%" height="500"></iframe>

### 4.9 Which authors and institutions are the ones with most articles rejected?

#### Authors

|Autores                               |Institution                                          | Frec|
|:-------------------------------------|:----------------------------------------------------|----:|
|Flávia Gonçalves   Fernandes          |Universidade Federal de Goiás - UFG                  |    4|
|Carla Diacui Medeiros   Berkenbrock   |UDESC                                                |    3|
|Mohanad                               |Al-hikma University                                  |    3|
|Naidson Clayr   Santos Ferreira       |Instituto Federal de Educação, Ciência e Tecnologia  |    3|
|Alexandra Katiuska Ramos   Diaz       |Universidade de São Paulo                            |    2|
|Almir Pereira   Guimarães             |Federal University of Alagoas                        |    2|
|Aloysio Augusto Rabello de   Carvalho |Universidade Federal de São Paulo                    |    2|
|Ana   Cervigni                        |Centro de Tecnologia da Informação Renato Archer-CTI |    2|
|Beatriz Terezinha   Borsoi            |Universidade Tecnológica Federal do Paraná           |    2|
|Bharti   Bisht                        |MRIIRS                                               |    2|

#### Institutions

|Instituciones                               | Frec|
|:-------------------------------------------|----:|
|Fundação Educacional de Fernandópolis       |   12|
|Universidade Estadual de Maringá            |   12|
|Universidade Tecnológica Federal do Paraná  |   11|
|Universidade de São Paulo                   |    9|
|Universidade Federal do Pará                |    6|
|Universidade do Vale do Itajaí              |    5|
|Universidade Federal de Goiás - UFG         |    5|
|Universidade Federal do Rio Grande do Norte |    5|
|Universidade Federal Rural de Pernambuco    |    5|
|UTFPR                                       |    5|


### 4.10 How different was the keywords of the rejected articles compared to the accpeted ones?

#### Areas and Sub-areas of study observed in 2023

![Areas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/area-rech-x-acceptos-2023.png)
![Subareas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/subareas-rech-x-acceptos-2023.png)

#### Areas and Sub-areas of study observed in 2018

![Areas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/area-rech-x-acceptos-2018.png)
![Subareas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/subareas-rech-x-acceptos-2018.png)

#### Areas and Sub-areas of study observed in 2013

![Areas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/area-rech-x-acceptos-2013.png)
![Subareas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/subareas-rech-x-acceptos-2013.png)

#### Areas and Sub-areas of study observed in 2008

![Areas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/area-rech-x-acceptos-2008.png)
![Subareas of study - 2023](C:/Users/ntu_c/metadata-article-ml/rpubs-images/subareas-rech-x-acceptos-2008.png)

# References

[Villalobos, M. (n.d.). *Rita: Exploratory Analysis and Visualization of Text*. Retrieved June 23, 2024](https://rpubs.com/mvillalobos/Rita)

[Barik, Nilaranjan, and Puspanjali Jena. 2019. “Bibliometric Portrait of Select Open Access Journals in the Field of Library and Information Science: A Scopus Based Analysis.” Library Philosophy and Practice 1: 1–8.](#)

[Das, Saumen, Kiran Kaur, and Manoj Kumar Verma. 2021. “Publication and Collaboration Pattern of College and Research Libraries Journal During 2009-2018: A Scientometric Analysis.” Library Philosophy and Practice 5118.](#)

[Gupta, Simran, and Nabi Hasan. 2018. “Scientometric Analysis of Metamorphosis: A Journal of Management Research.” DESIDOC Journal of Library & Information Technology 38 (4): 254–58. https://doi.org/10.14429/djlit.38.4.12511.](https://doi.org/10.14429/djlit.38.4.12511)

[Kulkanjanapiban, Pachisa, and Tipawan Silwattananusarn. 2021. “Bibliometric Analysis of Publications in the Scopus Database: A Study at Prince of Songkla University (PSU) During 1978-2021.” Library Philosophy and Practice 125: 23001.](#)

[Kumar, R. Santha, and K. Kaliyaperumal. 2015. “Scientometric Analysis of Global Publication Output in Mobile Technology.” DESIDOC Journal of Library and Information Technology 35 (4): 287–92. https://doi.org/10.14429/djlit.35.4.7884.](https://doi.org/10.14429/djlit.35.4.7884)

[Rathika, N., and S. Thanuskodi. 2021. “Studies on Relative Growth Rate and Doubling Time of Publications Productivity of Nuclear Medicine Research.” Journal of Pharmaceutical Research International, 198–211. https://doi.org/10.9734/jpri/2021/v33i32a31732.](https://doi.org/10.9734/jpri/2021/v33i32a31732)

[Savanur, Kiran, and R. Srikanth. 2009. “Modified Collaborative Coefficient: A New Measure for Quantifying the Degree of Research Collaboration.” Scientometrics 84 (2): 365–71. https://doi.org/10.1007/s11192-009-0100-4.](https://doi.org/10.1007/s11192-009-0100-4)


