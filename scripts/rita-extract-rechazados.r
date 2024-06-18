library("stringr")
library("dplyr")

datos=read.csv("/cloud/project/dataset/BD_RITA02.csv",sep=",",header=T)

idx=which(datos$Status=="Declined")

print("Inicia el processo de artigos rechazados")

salida_rechazados = NULL
contador = 0

for (a in idx){
  
  contador=contador+1 
  print(paste("Procesando",a,"Iteração:",contador,"de",length(idx),sep=" "))
  
  
  primero_autor_nombre = paste(datos$Given.Name..Author.1.[a], " ", datos$Family.Name..Author.1.[a])
  universidade_autor = datos$Affiliation..Author.1.[a]
  
  #Elimino saltos de líneas...
  universidade_autor=str_remove_all(universidade_autor,"\n")
  universidade_autor=str_remove_all(universidade_autor,";")
  universidade_autor=str_remove_all(universidade_autor,"|")
  universidade_autor=str_remove_all(universidade_autor,"\r")  
  
  #Años
  ano=datos$Date.submitted[a]
  ano=substring(ano,0,4) #Slice the date format YYYY-MM-DD to get year
  
  idioma=datos$Language[a]
  
  status=datos$Status[a]

  
  salida_rechazados=rbind (salida_rechazados,data.frame(doc=datos$Submission.ID[a],
                                                        authors=primero_autor_nombre,
                                                        institution=universidade_autor,
                                                        title=datos$Title[a],
                                                        abstract=datos$Abstract.EN[a],
                                                        keywords=datos$Keywords.EN[a],
                                                        language=idioma, 
                                                        status_article=status,
                                                        pages=0,
                                                        year=ano,
                                                        date=datos$Date.submitted[a]))
  
}


#salida_rechazados_unicos <- distinct(salida_rechazados, doc, .keep_all = TRUE)

write.table(salida_rechazados,"/cloud/project/dataset/BD_RITA_RECHAZADOS.csv",sep=";",row.names=F,quote = F)