# 16 Years of Rita - A bibliometric analysis

## 1.Introduction

Rita is an brazilian scientific magazine that surges in 1989 with the mission to have a regular and strong computer science publication in the Informatics Institute - UFRGS. Since them, lots of changes have in article publication and RITA follows most of it into the academic community. With a digital format of publication since 2008, we have 16 years of article knowledge stored in our database and we want to make an exploratory analysis:

    * the subject of publications that we did have here (and the variations on that across time)
    * indexes of publications related to institutions and authors
    * the volume of publications that occurs from 2008 to 2023
    * the contributions between authors across the globe
    

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

![Table with metric description (Donthu et al., 2021)](/cloud/project/rpubs-images/toolbox_metrics_overview.png)

### Setup an bibliometric analysis and explain a little bit on how it works in detriment of other methods
    * Explain the bibliometric analysis
    * contrast with other methods
    
### Architeture overview on how we get the results
    * Image of overview architeture
    * Briefly explain each step accordling
    
    
# Questions to try to answer with the results

Análise Temporal:

    Como evoluiu o número de publicações na revista ao longo dos 15 anos?
    Quais anos tiveram o maior e o menor número de publicações?

Temas e Tópicos de Pesquisa:

    Quais foram os principais temas/tópicos abordados nos artigos ao longo dos 15 anos?
    Como evoluíram os temas/tópicos de pesquisa na revista ao longo do tempo?

Autores e Contribuições:

    Quem são os autores mais prolíficos da revista nos últimos 15 anos?
    Quais são as instituições mais frequentemente representadas entre os autores?


Colaborações:

    Qual é a rede de colaboração entre autores nos artigos da revista?
    Quais são os países mais representados em colaborações internacionais nos artigos?

Distribuição Geográfica:

    Qual é a distribuição geográfica dos autores dos artigos publicados na revista?
    Quais países tiveram um aumento ou diminuição na contribuição ao longo dos anos?

Revistas e Impacto Relativo:

    Como o fator de impacto da revista evoluiu ao longo dos 15 anos?
    Quais são as revistas concorrentes e como elas se comparam em termos de impacto e citações?

Padrões de Publicação:

    Quais tipos de artigos (revisões, estudos empíricos, teóricos, etc.) são mais comuns na revista?
    Houve mudanças nos tipos de artigos publicados ao longo dos anos?

Palavras-chave e Tópicos Emergentes:

    Quais são as palavras-chave mais frequentemente utilizadas nos artigos ao longo dos 15 anos?
    Quais são os tópicos emergentes identificados a partir da análise de palavras-chave?

Autores mais Citados:

    Quais autores tiveram os artigos mais citados publicados na revista?
    Existe uma correlação entre a afiliação dos autores mais citados e o número de citações?

Índices de Diversidade:

    Qual é a diversidade de afiliações institucionais e geográficas entre os autores?
    Como evoluiu a diversidade de autores e afiliações ao longo do tempo?

Tempos de Submissão e Publicação:

    Qual é o tempo médio de revisão e publicação dos artigos na revista?
    Houve mudanças nos tempos de revisão e publicação ao longo dos 15 anos?


# End questions


# The Results

## Indexers related to the number of publications:

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

## Indexes related to the authors:

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


### Promedio de publicaciones
### Promedio de paginas
### Promedio de visualizações


P.S: lembrar de colocar as instituições nas tabelas de autores


### Autores que mais publicaram - Agregado até 2023

|Autores                          | Frec|
|:--------------------------------|----:|
|Anderson Faustino da Silva       |    6|
|José Palazzo Moreira de Oliveira |    6|
|Aldo von Wangenheim              |    4|
|Eanes Torres Pereira             |    4|
|Luciano Antonio Digiampietri     |    4|
|Alfredo Silveira Araújo Neto     |    3|
|Antônio Carlos Rocha Costa       |    3|
|Gustavo Rau de Almeida Callou    |    3|
|Ivan Torres Pisa                 |    3|
|Jaime Simão Sichman              |    3|


### Instituiçoes que mais publicaram - Agregado até 2023

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


    
## Question para Artigos Publicados

###Como variaram os indicadores bibliométricos de publicações desde de 2008 até 2023?

<iframe src="/cloud/project/rpubs-interactive-graph/publications_year.html" width="100%" height="500"></iframe>

<iframe src="/cloud/project/rpubs-interactive-graph/pub_year_accept_declined.html" width="100%" height="500"></iframe>



### Agregado de visualizações dos artigos por ano?



<iframe src="/cloud/project/rpubs-interactive-graph/total_views_aggregated_by_year.html" width="100%" height="500"></iframe>

### Top 20 artigos mais visualizados:



|author                         |title                                                                                                                      | Views| year|
|:------------------------------|:--------------------------------------------------------------------------------------------------------------------------|-----:|----:|
|André C. P. L. F. de Carvalho  |Uma Introdução às Support Vector Machines                                                                                  | 51663| 2008|
|Maurício Marengoni             |Tutorial: Introdução à Visão Computacional usando OpenCV                                                                   | 27564| 2009|
|Adriana Bordini                |QEDS: Um Simulador Clássico para Distinção de Elementos Quântico                                                           | 25779| 2016|
|Lino Sanabria                  |Estudo do Padrão Avançado de Criptografia AES – Advanced Encryption Standard                                               | 13048| 2011|
|Paulo Blauth Menezes           |Teorias da Aleatoriedade                                                                                                   |  9708| 2008|
|Rafael Prikladnicki            |Um Olhar Sociotécnico sobre a Engenharia de Software                                                                       |  9613| 2008|
|Jacques Wainer                 |Processos de Decisão de Markov: um tutorial                                                                                |  9516| 2008|
|Siome Klein Goldenstein        |A Gentle Introduction to Predictive Filters                                                                                |  9225| 2008|
|Rafael Santos                  |Java Advanced Imaging API: A Tutorial                                                                                      |  8010| 2008|
|Heimar de Fátima Marin         |Desenvolvimento e Avaliação de um Protocolo Eletrônico para Atendimento e Monitoramento do Paciente com Doença Celíaca     |  5946| 2010|
|Alane Marie de Lima            |Formal Semantics for Java-like Languages and Research Opportunities                                                        |  5705| 2018|
|Cássio Martini Martins Pereira |Common Dissimilarity Measures are Inappropriate for Time Series Clustering                                                 |  5103| 2011|
|Débora Cristine Xavier         |Análise do Controle Motor com Interações usando Dispositivos Convencionais e Realidade Aumentada                           |  4449| 2009|
|Fernando Gomes Pires           |Software para Auxílio no Processo de Elaboração do Cariótipo                                                               |  4352| 2014|
|Abilio Parada                  |Automating mobile application development: UML-based code generation for Android and Windows Phone                         |  4309| 2015|
|Arnaldo de Albuquerque Araújo  |Efeitos Visuais, uma Abordagem a Partir do Processamento Digital de Imagens                                                |  3814| 2009|
|Rebeca Schroeder Freitas       |Mineração em Grandes Massas de Dados Utilizando Hadoop MapReduce e Algoritmos Bio-inspirados: Uma Revisão Sistemática      |  3731| 2015|
|Anderson Faustino da Silva     |Prolog: A Linguagem, A Máquina Abstrata de Warren e Implementações                                                         |  3724| 2013|
|Victor Wanderley               |Estudo e Modelagem dos Efeitos da Forma e do Crescimento em Processos de Formação de Padrões de Pelagem via Reação-Difusão |  3281| 2017|
|Claudia Marcela Justel         |The Design of a Graphics Engine for the Development of Virtual Reality Applications                                        |  3197| 2009|


P.s: regressão com relação de busca por tematica

## Total of articles received by RITA classified by language


<iframe src="/cloud/project/rpubs-interactive-graph/total_submissions_aggregated_language.html" width="100%" height="500"></iframe>


P.s: analise feita apenas com base nos metadados registrados



# Qual a variação dos assuntos publicados na revista ao longo dos anos?

### Areas of study observed in 2023

![Areas of study - 2023](/cloud/project/rpubs-images/areas_study_2023.png)

### Sub-areas of study observed in 2023

![Subareas of study - 2023](/cloud/project/rpubs-images/subareas_study_2023.png)



### Areas of study observed in 2018

![Areas of study - 2018](/cloud/project/rpubs-images/areas_study_2018.png)

### Sub-areas of study observed in 2018

![Subareas of study - 2018](/cloud/project/rpubs-images/subareas_study_2018.png)



### Areas of study observed in 2013

![Areas of study - 2013](/cloud/project/rpubs-images/areas_study_2013.png)

### Sub-areas of study observed in 2013

![Subareas of study - 2013](/cloud/project/rpubs-images/subareas_study_2013.png)



### Areas of study observed in 2008

![Areas of study - 2008](/cloud/project/rpubs-images/areas_study_2008.png)

### Sub-areas of study observed in 2008

![Subareas of study - 2008](/cloud/project/rpubs-images/subareas_study_2008.png)



# Grafos de localidade entre autores:


### Map with aggregated locations of authors


<iframe src="/cloud/project/rpubs-interactive-graph/graph_total_aggregated_authors_location.html" width="100%" height="500"></iframe>



### Total authors location in 2023


<iframe src="/cloud/project/rpubs-interactive-graph/graph_authors_location_2023.html" width="100%" height="500"></iframe>


### Total authors location in 2018


<iframe src="/cloud/project/rpubs-interactive-graph/graph_authors_location_2018.html" width="100%" height="500"></iframe>


### Total authors location in 2013


<iframe src="/cloud/project/rpubs-interactive-graph/graph_authors_location_2013.html" width="100%" height="500"></iframe>


### Total authors location in 2008


<iframe src="/cloud/project/rpubs-interactive-graph/graph_authors_location_2008.html" width="100%" height="500"></iframe>



# Question para Artigos Rejeitados

## Quais são as instituições e autores com o maior numero de artigos rejeitados?

### Autores

|Autores                             | Frec|
|:-----------------------------------|----:|
|Mário   Leite                       |    6|
|Flávia Gonçalves   Fernandes        |    5|
|Carla Diacui Medeiros   Berkenbrock |    3|
|Diogo Fernando   Trevisan           |    3|
|José dos Santos   Machado           |    3|
|Mohanad                             |    3|
|Naidson Clayr   Santos Ferreira     |    3|
|Rodrigo Duarte   Seabra             |    3|
|Tiago Carmo   Nogueira              |    3|
|Alane Marie   de Lima               |    2|

### Instituições


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


##Em quais temas se encaixam os assuntos rejeitados e como estes variam ao longo dos anos?

P.s: modificar teste para fazer Rejeitados x Aceitos

### Areas of study observed in 2023

![Areas of study - 2023](/cloud/project/rpubs-images/areas_rechazados_2023.png)

### Sub-areas of study observed in 2023

![Subareas of study - 2023](/cloud/project/rpubs-images/subareas_rechazados_2023.png)



### Areas of study observed in 2018

![Areas of study - 2018](/cloud/project/rpubs-images/areas_rechazados_2018.png)

### Sub-areas of study observed in 2018

![Subareas of study - 2018](/cloud/project/rpubs-images/subareas_rechazados_2018.png)



### Areas of study observed in 2013

![Areas of study - 2013](/cloud/project/rpubs-images/areas_rechazados_2013.png)

### Sub-areas of study observed in 2013

![Subareas of study - 2013](/cloud/project/rpubs-images/subareas_rechazados_2013.png)



### Areas of study observed in 2008

![Areas of study - 2008](/cloud/project/rpubs-images/areas_rechazados_2008.png)

### Sub-areas of study observed in 2008

![Subareas of study - 2008](/cloud/project/rpubs-images/subareas_rechazados_2008.png)
