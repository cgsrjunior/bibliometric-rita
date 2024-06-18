library("dplyr")   #Ordenamiento de datos
library(knitr)
library(lubridate)

#datos = read.csv("/cloud/project/dataset/BD_RITA_ACCEPTADOS.csv",sep=",",header=T)
datos = read.csv("/cloud/project/dataset/BD_RITA_RECHAZADOS.csv",sep=";",header=T)

datos=datos[which(datos$institution!=""),]

#=========================================================================================================
# Esto está pensado para Shiny, debe ser capaz además de considerar el acumulado por año
#=========================================================================================================

#Filtro por año. También debe incluir la opción ALL
ano="2023"
acumulado = T

# First start with authors

if (acumulado==F) {datos=datos[which(datos$year==ano),]} else
{datos=datos[which(datos$year<=ano),]} 

autores=data.frame(table(datos$authors))
autores=autores[order(autores$Freq,decreasing = T),]
rownames(autores)=NULL
names(autores)=c("Autores","Frec")

top_10_authors = knitr::kable(head(autores,10))
print(top_10_authors)

# Authors graph

library("igraph")
library("networkD3")
documentos=unique(datos$doc)
autores=sort(unique(datos$authors))

matriz_autores=matrix(0,ncol=length(autores),nrow=length(autores))
rownames(matriz_autores)=colnames(matriz_autores)=autores

for (a in 1:length(autores))
{ idx=datos$authors[which(datos$doc==documentos[a])]
matriz_autores[idx,idx]=matriz_autores[idx,idx]+1
}

for (a in 1:length(autores))
{matriz_autores[a,a]=0}

g1 = graph_from_adjacency_matrix(matriz_autores,weighted=T,mode="directed")
simpleNetwork(as_data_frame(g1),zoom=T,linkDistance = 30)

# Institutions

instituciones=datos$institution[which(datos$institution!="-")]
instituciones=data.frame(table(instituciones))
instituciones=instituciones[order(instituciones$Freq,decreasing = T),]
rownames(instituciones)=NULL
names(instituciones)=c("Instituciones","Frec")

top_10_institutions_by_freq = knitr::kable(head(instituciones,10))
print(top_10_institutions_by_freq)


# Graph institutions

norm_institution=sort(unique(datos$institution))

matriz_institution=matrix(0,ncol=length(norm_institution),nrow=length(norm_institution))
rownames(matriz_institution)=colnames(matriz_institution)=norm_institution

for (a in 1:length(norm_institution))
{ idx=datos$institution[which(datos$doc==documentos[a])]
matriz_institution[idx,idx]=matriz_institution[idx,idx]+1
}

for (a in 1:length(norm_institution))
{matriz_institution[a,a]=0}

g1 = graph_from_adjacency_matrix(matriz_institution,weighted=T,mode="directed")

simpleNetwork(as_data_frame(g1),zoom=T,linkDistance = 30)

