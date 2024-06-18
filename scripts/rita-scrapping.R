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


library("stringr")
library("rvest")      #Contiene las funciones para webscraping
library("dplyr")

datos=read.csv("/cloud/project/dataset/BD_RITA02.csv",sep=",",header=T)

#Sólo considerará los artículos publicados debido a que los datos de los artículos
#en revisión no están en la web

idx=which(datos$Status=="Published")
salida=NULL
salida_rechazados=NULL
contador=0

print("Inicia a processo del datos publicados")

for (a in idx)
{
  contador=contador+1 
  print(paste("Procesando",a,"Iteração:",contador,"de",length(idx),sep=" "))
  
  str_index = toString(a)
  
  url <- switch(str_index, 
                "899"=paste("https://seer.ufrgs.br/index.php/rita/article/view/125288"),
                "916"=paste("https://seer.ufrgs.br/index.php/rita/article/view/126544"),
                "923"=paste("https://seer.ufrgs.br/index.php/rita/article/view/128836"),
                "925"=paste("https://seer.ufrgs.br/index.php/rita/article/view/129783"),
                "926"=paste("https://seer.ufrgs.br/index.php/rita/article/view/129787"),
                "927"=paste("https://seer.ufrgs.br/index.php/rita/article/view/129990"),
                "942"=paste("https://seer.ufrgs.br/index.php/rita/article/view/130669"),
                paste("http://dx.doi.org/",datos$DOI[a],sep=""))
  
  documento=read_html(url)
  
  #autores
  autores=html_attr(html_nodes(documento, "meta[name=citation_author]"),'content')
  
  #universidades
  universidades=html_attr(html_nodes(documento, "meta[name=citation_author_institution]"),'content')
  if (length(universidades)<length(autores)){universidades=c(universidades,rep("-",length(autores)
                                                                               -length(universidades)))}
  
  #Elimino saltos de líneas...
  universidades=str_remove_all(universidades,"\n")
  universidades=str_remove_all(universidades,";")
  universidades=str_remove_all(universidades,"|")
  universidades=str_remove_all(universidades,"\r")  
  
  #Páginas
  pagina_ini=as.numeric(html_attr(html_nodes(documento, "meta[name=citation_firstpage]"),'content'))
  pagina_fin=as.numeric(html_attr(html_nodes(documento, "meta[name=citation_lastpage]"),'content'))
  num_paginas=pagina_fin-pagina_ini
  if (length(num_paginas)==0){num_paginas=rep("-",length(autores))}
  
  #Años
  ano=datos$Date.submitted[a]
  ano=substring(ano,0,4) #Slice the date format YYYY-MM-DD to get year
  
  idioma=datos$Language[a]
  
  status=datos$Status[a]
  
  salida=rbind (salida,data.frame(doc=datos$Submission.ID[a],
                                  authors=autores,
                                  title=datos$Title[a],
                                  abstract=datos$Abstract.EN[a],
                                  keywords=datos$Keywords.EN[a],
                                  institution=universidades,
                                  language=idioma, 
                                  status_article=status,
                                  pages=num_paginas,
                                  year=ano,
                                  date=datos$Date.submitted[a]))
}

write.table(salida,"/cloud/project/dataset/BD_RITA03.csv",sep=";",row.names=F,quote = F)
