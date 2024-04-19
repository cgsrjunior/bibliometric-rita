datos=read.csv("C://Users/ntu_c/metadata-article-ml/dataset/BD_RITA04.csv",sep=",",header=T)

library(nominatimlite)  #En reemplazo de la biblioteca de goopleMaps


ciudades=unique(datos$city)
latitud=rep("-",length(ciudades))
longitud=latitud

for (a in 1:length(ciudades))
{
  print(paste("Analizando",a,"de",length(ciudades), "Ciudad:", ciudades[a],sep=" "))
  latlong=geo_lite(ciudades[a], lat="latitude", long="longitude")
  latitud[a]=latlong$latitude
  longitud[a]=latlong$longitude
}

datos2=data.frame(ciudades,latitud,longitud)

datos3=merge(datos,datos2,by.x = "city",by.y="ciudades")
datos3=datos3[,c(2,3,4,6,7,8,9,10,5,1,11,12)]

# Corrigi nome de uma coluna que ficou brazil por algum motivo
names(datos3)[names(datos3) == "Brazil"] <- "country"

# Substituir NA diretamente sem usar 'which'
# Not necessary due manual revision
# datos3$latitud[is.na(datos3$latitud)] <- "-"
# datos3$longitud[is.na(datos3$longitud)] <- "-"

write.table(datos3,"C://Users/ntu_c/metadata-article-ml/dataset/BD_RITA05.csv",sep=";",row.names=F,quote = F)
