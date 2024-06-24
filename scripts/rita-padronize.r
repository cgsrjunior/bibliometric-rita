#Bibliotecas
library("quanteda")
library("quanteda.textplots")
#library("quanteda.corpora")
library("quanteda.textmodels")
library("quanteda.textstats")
library("quanteda.textplots")
library("stringr")
library("lubridate")

#Lectura de datos
#Datos originales
#datos=read.csv("/cloud/project/dataset/BD_RITA_ACCEPTADOS.csv",sep=",",header=T)
datos=read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/BD_RITA_RECHAZADOS.csv",sep=";",header=T)
#Tesauro
thesaurus=read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/IEEE_tesauro.csv",sep=";",header = T)


names(thesaurus)=c("Area1","Area2","Area3","Area4", "Area5", "Area6")

thesaurus_subareas=unique(thesaurus$Area4)

#Filtrado de datos publicados
#datos=datos[which(datos$Status=="Published"),]


#Creación del corpus: los datos son convertidos a formato de corpus
corpus_datos = corpus(datos, text_field = "abstract")
#summary(corpus_datos,5)
#Tokenizatión: los datos son tokenizados, estandarizando el texto
toks_datos = tokens(corpus_datos,remove_punct = T,remove_symbols = T, remove_numbers = T, remove_url = T,
                    remove_separators = T)
#Convertir mayúsculas a minúsculas
toks_datos=tokens_tolower(toks_datos)



#Filtramos del tokenizado sólos las palabras similares a las subáreas del tesauro
kw_datos = kwic(toks_datos, pattern = phrase(thesaurus_subareas))
#Nos quedamos sólo con los elementos relevantes
kw_datos$from=kw_datos$from=kw_datos$to=kw_datos$pre=kw_datos$post=kw_datos$pattern=NULL
#Le agregamos a kw_datos los años
corpus_organizado=summary(corpus_datos,n=length(kw_datos$docname))
kw_datos=merge(kw_datos,corpus_organizado[,c("Text","year")],by.x="docname",by.y = "Text")


#Transfomación de kw en corpus
corpus_kw = corpus(kw_datos,text_field="keyword")
toks_datos_the = tokens(corpus_kw)
toks_datos_the = tokens_compound(toks_datos_the, pattern = phrase(thesaurus_subareas))
dfmat_datos_the = dfm(toks_datos_the)

#=========================================================================================================
# Esto está pensado para Shiny, debe ser capaz además de considerar el acumulado por año, hasta el 2020
#=========================================================================================================

ano="2023" 
acumulado=F #En este caso sólo puede llegar al 2020

#Graficar

if (acumulado==F){tstat_key = textstat_keyness(dfmat_datos_the,target = dfmat_datos_the$year == ano)} else
{tstat_key = textstat_keyness(dfmat_datos_the,target = dfmat_datos_the$year <= ano)}

grafico_sub_areas=textplot_keyness(tstat_key,labelsize = 4,n=10,margin = 0.6, 
                                   color = c("mediumaquamarine", "gray"))

#Areas
thesaurus$Area4=tolower(thesaurus$Area4)
kw_datos2=merge(kw_datos,thesaurus[,c("Area2","Area4")],by.x="keyword",by.y="Area4")
corpus_kw = corpus(kw_datos2,text_field="Area2")
toks_datos_the = tokens(corpus_kw,remove_punct = T,remove_symbols = T, remove_numbers = T, remove_url = T,
                        remove_separators = T)
toks_datos_the = tokens_compound(toks_datos_the, pattern = phrase(thesaurus$Area2))
dfmat_datos_the = dfm(toks_datos_the)

#Graficar
if (acumulado==F) {tstat_key = textstat_keyness(dfmat_datos_the,target = dfmat_datos_the$year == ano)} else
{tstat_key = textstat_keyness(dfmat_datos_the,target = dfmat_datos_the$year <= ano)}  

grafico_areas=textplot_keyness(tstat_key,labelsize = 4,n=10,margin = 0.6, 
                               color = c("mediumaquamarine", "gray"))