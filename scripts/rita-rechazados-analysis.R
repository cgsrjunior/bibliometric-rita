#Lectura de datos
#Datos originales
datos=read.csv("/cloud/project/dataset/BD_RITA_RECHAZADOS.csv",sep=";",header=T)

#Tesauro
thesaurus=read.csv("/cloud/project/dataset/IEEE_tesauro.csv",sep=";",header = T)
thesaurus_subareas=unique(thesaurus$NA..4)

#=========================================================================================================
# Esto está pensado para Shiny, debe ser capaz además de considerar el acumulado por año
#=========================================================================================================

ano= "2021"
acumulado = F

if (acumulado==F){datos=datos[which(datos$year==ano),]} else
{datos=datos[which(datos$year<=ano),]}

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
kw_datos=merge(kw_datos,corpus_organizado[,c("Text","status_article")],by.x="docname",by.y = "Text")

#Transfomación de kw en corpus
corpus_kw = corpus(kw_datos,text_field="keyword")
toks_datos_the = tokens(corpus_kw)
toks_datos_the = tokens_compound(toks_datos_the, pattern = phrase(thesaurus_subareas))
dfmat_datos_the = dfm(toks_datos_the)

#=========================================================================================================
# Esto está pensado para Shiny, debe ser capaz además de considerar el acumulado por año
#=========================================================================================================

#Graficar
tstat_key = textstat_keyness(dfmat_datos_the)
grafico_sub_areas=textplot_keyness(tstat_key,labelsize = 4,n=10,margin = 0.6, 
                                   color = c("mediumaquamarine", "gray"))

#Areas
thesaurus$NA..4=tolower(thesaurus$NA..4)
kw_datos2=merge(kw_datos,thesaurus[,c("NA..2","NA..4")],by.x="keyword",by.y="NA..4")
corpus_kw = corpus(kw_datos2,text_field="NA..2")
toks_datos_the = tokens(corpus_kw,remove_punct = T,remove_symbols = T, remove_numbers = T, remove_url = T,
                        remove_separators = T)
toks_datos_the = tokens_compound(toks_datos_the, pattern = phrase(thesaurus$NA..2))
dfmat_datos_the = dfm(toks_datos_the)

#Graficar
tstat_key = textstat_keyness(dfmat_datos_the)
grafico_areas=textplot_keyness(tstat_key,labelsize = 4,n=10,margin = 0.6, 
                               color = c("mediumaquamarine", "gray"))