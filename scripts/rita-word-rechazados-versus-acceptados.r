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
datos=read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/BD_RITA_RECHAZADOS.csv",sep=";",header=T)
datos_acceptados=read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/BD_RITA_ACCEPTADOS.csv",sep=",",header=T)

#Tesauro
thesaurus=read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/IEEE_tesauro.csv",sep=";",header = T)
names(thesaurus)=c("Area1","Area2","Area3","Area4", "Area5", "Area6")

thesaurus_subareas=unique(thesaurus$Area4)


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

##### AHORA PARA DATOS ACCEPTOS ##########################

#Creación del corpus: los datos son convertidos a formato de corpus
corpus_acceptos = corpus(datos_acceptados, text_field = "abstract")
#summary(corpus_datos,5)
#Tokenizatión: los datos son tokenizados, estandarizando el texto
toks_acceptos = tokens(corpus_acceptos,remove_punct = T,remove_symbols = T, remove_numbers = T, remove_url = T,
                       remove_separators = T)
#Convertir mayúsculas a minúsculas
toks_acceptos=tokens_tolower(toks_acceptos)


#Filtramos del tokenizado sólos las palabras similares a las subáreas del tesauro
kw_acceptos = kwic(toks_acceptos, pattern = phrase(thesaurus_subareas))
#Nos quedamos sólo con los elementos relevantes
kw_acceptos$from=kw_acceptos$from=kw_acceptos$to=kw_acceptos$pre=kw_acceptos$post=kw_acceptos$pattern=NULL
#Le agregamos a kw_acceptos los años
corpus_org_acceptos=summary(corpus_acceptos,n=length(kw_acceptos$docname))
kw_acceptos=merge(kw_acceptos,corpus_org_acceptos[,c("Text","year")],by.x="docname",by.y = "Text")


#Transfomación de kw en corpus
corpus_kw_acceptos = corpus(kw_acceptos,text_field="keyword")
toks_acceptos_the = tokens(corpus_kw_acceptos)
toks_acceptos_the = tokens_compound(toks_acceptos_the, pattern = phrase(thesaurus_subareas))
dfmat_acceptos_the = dfm(toks_acceptos_the)



#=========================================================================================================
# Esto está pensado para Shiny, debe ser capaz además de considerar el acumulado por año, hasta el 2020
#=========================================================================================================

# Defina o ano de interesse
ano <- "2023"

# Filtrar documentos por ano
dfmat_acceptos_the_year <- dfm_subset(dfmat_acceptos_the, docvars(dfmat_acceptos_the, "year") == ano)
dfmat_datos_the_year <- dfm_subset(dfmat_datos_the, docvars(dfmat_datos_the, "year") == ano)

# Verifique o número de documentos após a filtragem
num_acceptos <- ndoc(dfmat_acceptos_the_year)
num_datos <- ndoc(dfmat_datos_the_year)
print(num_acceptos)  # Deve imprimir o número de documentos em dfmat_acceptos_the_year
print(num_datos)  # Deve imprimir o número de documentos em dfmat_datos_the_year

# Combine os dois dfm filtrados
dfmat_combined_year <- rbind(dfmat_datos_the_year, dfmat_acceptos_the_year)

# Verifique o número de documentos no dfmat combinado
num_combined <- ndoc(dfmat_combined_year)
print(num_combined)  # Deve ser igual a num_acceptos + num_datos

# Crie um vetor target
target_vector_year <- c(rep(TRUE, num_datos), rep(FALSE, num_acceptos))

# Verifique o comprimento do vetor target
print(length(target_vector_year))  # Deve ser igual a num_combined

# Calcular a keyness
tstat_key_year <- textstat_keyness(dfmat_combined_year, target = target_vector_year)

# Visualizar os resultados
print(tstat_key_year)
#Graficar
grafico_sub_areas=textplot_keyness(tstat_key_year,labelsize = 4,n=10,margin = 0.6,
                                   color = c("red", "blue"))


#Areas

########### Para los rechazados

thesaurus$Area4=tolower(thesaurus$Area4)
kw_datos2=merge(kw_datos,thesaurus[,c("Area2","Area4")],by.x="keyword",by.y="Area4")
corpus_kw = corpus(kw_datos2,text_field="Area2")
toks_datos_the = tokens(corpus_kw,remove_punct = T,remove_symbols = T, remove_numbers = T, remove_url = T,
                        remove_separators = T)
toks_datos_the = tokens_compound(toks_datos_the, pattern = phrase(thesaurus$Area2))
dfmat_datos_the = dfm(toks_datos_the)

########## Para los acceptos

thesaurus$Area4=tolower(thesaurus$Area4)
kw_acceptos2=merge(kw_acceptos,thesaurus[,c("Area2","Area4")],by.x="keyword",by.y="Area4")
corpus_kw_acceptos = corpus(kw_acceptos2,text_field="Area2")
toks_acceptos_the = tokens(corpus_kw_acceptos,remove_punct = T,remove_symbols = T, remove_numbers = T, remove_url = T,
                        remove_separators = T)
toks_acceptos_the = tokens_compound(toks_acceptos_the, pattern = phrase(thesaurus$Area2))
dfmat_acceptos_the = dfm(toks_acceptos_the)


# Filtrar documentos por ano
dfmat_acceptos_the_year <- dfm_subset(dfmat_acceptos_the, docvars(dfmat_acceptos_the, "year") == ano)
dfmat_datos_the_year <- dfm_subset(dfmat_datos_the, docvars(dfmat_datos_the, "year") == ano)

# Verifique o número de documentos após a filtragem
num_acceptos <- ndoc(dfmat_acceptos_the_year)
num_datos <- ndoc(dfmat_datos_the_year)
print(num_acceptos)  # Deve imprimir o número de documentos em dfmat_acceptos_the_year
print(num_datos)  # Deve imprimir o número de documentos em dfmat_datos_the_year

# Combine os dois dfm filtrados
dfmat_combined_year <- rbind(dfmat_datos_the_year, dfmat_acceptos_the_year)

# Verifique o número de documentos no dfmat combinado
num_combined <- ndoc(dfmat_combined_year)
print(num_combined)  # Deve ser igual a num_acceptos + num_datos

# Crie um vetor target
target_vector_year <- c(rep(TRUE, num_datos), rep(FALSE, num_acceptos))

# Verifique o comprimento do vetor target
print(length(target_vector_year))  # Deve ser igual a num_combined

# Calcular a keyness
tstat_key_year <- textstat_keyness(dfmat_combined_year, target = target_vector_year)

# Visualizar os resultados
print(tstat_key_year)

grafico_areas=textplot_keyness(tstat_key_year,labelsize = 4,n=10,margin = 0.6, 
                               color = c("red", "blue"))


