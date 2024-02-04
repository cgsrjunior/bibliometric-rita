#*******************************************************************************
#* Disclaimer: this code is an modified version of the following code cited below
#* 
#*    Title: Bibliometric analysis of published research in Revista
#*           de Informática Teórica e Aplicada (RITA) from 2008 to 2021
#*    Author: M Villalobos-Cid
#*    Date: 2023
#*    Code version: 1.0
#*    Availability: https://rpubs.com/mvillalobos/Rita
#*
#*******************************************************************************

datos=read.csv("C://Users/ntu_c/metadata-article-ml/dataset/BD_RITA03.csv",sep=";",header=T)

#datos complementarios
datos_comp=read.csv("C://Users/ntu_c/metadata-article-ml/dataset/views-20231205.csv",sep=",",header=T)

datos=merge(datos,datos_comp[,c("Article.ID","Total.Galley.Views")],by.x = "doc",by.y="Article.ID",all = T)

names(datos)[1]="doc"
names(datos)[7]="Views"

#Corregir un dato erróneo
datos$Views[which(is.na(datos$Views))]="none"


#Guardar
write.table(datos,"C://Users/ntu_c/metadata-article-ml/dataset/BD_RITA04.csv",sep=";",row.names=F,quote = F)
