library(tidyverse)
library(leaflet)
library(sf)
library(geosphere)

datos=read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/BD_RITA05.csv", sep=",",header = T)


if (length(which(datos$city=="-")>0))
{datos2=datos[-which(datos$city=="-"),]} else
{datos2=datos}


#=========================================================================================================
# Esto está pensado para Shiny, debe ser capaz además de considerar el acumulado por año
#=========================================================================================================

ano="2022"
acumulado=F #En este caso sólo puede llegar al 2020

#datos2$year==2022

if (acumulado==F){datos2=datos2[datos2$year==ano,]} else
{datos2=datos2[datos2$year<=ano,]}


datos2=data.frame(table(datos2$city))
names(datos2)=c("ciudad","autores")
datos3=unique(merge(datos2,datos[,c("city","latitud","longitud")],by.x="ciudad",by.y="city"))

m = leaflet()
m = setView(m,-14, 10, zoom = 2)
m = addProviderTiles(m,providers$CartoDB.Positron,
                     options = providerTileOptions(minZoom = 2, maxZoom = 10))


m = addCircleMarkers(m, lat = as.numeric(datos3$latitud),lng = as.numeric(datos3$longitud),
                     radius = (datos3$autores)*0.3,
                     stroke = T,
                     color = "darkgreen",
                     opacity = 0.2)


datos4=unique(merge(datos2,datos[,c("doc","city","latitud","longitud")],by.x="ciudad",by.y="city"))

documentos=unique(datos4$doc)
longitudes=NULL
latitudes=NULL
for (a in 1:length(documentos))
{
  datos4_tmp=datos4[which(datos4$doc==documentos[a]),]
  for (b in 1:(nrow(datos4_tmp)-1))
  { 
    if (nrow(datos4_tmp)>1)
    {latitudes=rbind(latitudes,datos4_tmp$latitud[c(b,b+1)])
    longitudes=rbind(longitudes,datos4_tmp$longitud[c(b,b+1)])
    }
  }
}


m=addPolylines(m,lng=as.numeric(longitudes), lat=as.numeric(latitudes), color="darkgreen", weight=2,opacity=0.2,stroke = T)



m =   setMaxBounds(m, lng1 = -200
                   , lat1 = -80
                   , lng2 = 200
                   , lat2 = 80 )

m
