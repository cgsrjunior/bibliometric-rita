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

datos=read.csv("/cloud/project/dataset/BD_RITA05.csv",sep=",",header=T)

#Using distinct ID to gather only the absolute number of visualization each year
datos_tmp = distinct(datos, doc, title, .keep_all = TRUE)

#datos complementarios
datos_comp=read.csv("/cloud/project/dataset/views-20231205.csv",sep=",",header=T)


datos=merge(datos_tmp,datos_comp[,c("Article.ID","Total.Galley.Views")],by.x = "doc",by.y="Article.ID",all = T)

names(datos)[1]="doc"
names(datos)[13]="Views"

#Corregir un dato erróneo
datos$Views[which(is.na(datos$Views))]="none"

#Guardar
datos = datos[complete.cases(datos), ]
write.table(datos,"/cloud/project/dataset/BD_RITA_DISTINCT_ACCEPTED.csv",sep=";",row.names=F,quote = F)
