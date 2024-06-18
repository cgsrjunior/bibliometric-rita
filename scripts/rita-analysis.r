library("ggplot2") #Gráficos
library("plotly")  #Gráficos
library("dplyr")   #Ordenamiento de datos
library(lubridate)


# Remember to change this for the next 
datos = read.csv("/cloud/project/dataset/BD_RITA02.csv",sep=",",header=T)

paleta = "Reds" #"Blues" "Zissou" "GrandBudapest"

#==========================================
#  Shiny - Selección  - Esto se debe controlar con shiny
#==========================================
#Publicados
b1=T
#Review
b2=F
#Rechazados
b3=F
#Submission
b4=F
#Copyediting
b5=F
#Production
b6=F

datos <- datos[datos$Status != "", ]


datos_tmp=datos

if (b1==F){datos_tmp=datos_tmp[which(datos_tmp$Status!="Published"),]}
if (b2==F){datos_tmp=datos_tmp[which(datos_tmp$Status!="Review"),]}
if (b3==F){datos_tmp=datos_tmp[which(datos_tmp$Status!="Declined"),]}

if (b4==F){datos_tmp=datos_tmp[which(datos_tmp$Status!="Submission"),]}
if (b5==F){datos_tmp=datos_tmp[which(datos_tmp$Status!="Copyediting"),]}
if (b6==F){datos_tmp=datos_tmp[which(datos_tmp$Status!="Production"),]}

# Convert the datetime column to Date class (if it's not already)
datos_tmp$Date.submitted <- as.Date(datos_tmp$Date.submitted)
# Extract the year from the datetime column
datos_tmp$Years <- year(datos_tmp$Date.submitted)
datos_tmp= datos_tmp %>% group_by(Status,Years) %>% summarize(n())
datos_tmp=data.frame(datos_tmp)
datos_tmp <- datos_tmp[!is.na(datos_tmp$Status), ]
# Contar o número de linhas
total_artigos <- nrow(datos)


g=ggplot(data=datos_tmp, aes(x=Years, y=n.., fill=Status)) +
  geom_bar(stat="identity") +
  scale_x_continuous(breaks = seq(2008, 2023, by = 1)) +
  theme_classic() + xlab("years") + ylab("# Submitted manuscripts (absolute frequency)") + ylim(0,150)+
  scale_fill_brewer(palette=paleta) + ggtitle("Publications by year")


ggplotly(g)
