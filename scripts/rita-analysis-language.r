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
b3=T
#Submission
b4=F
#Copyediting
b5=F
#Production
b6=F

#datos <- datos[datos$language != "", ]
#datos <- datos[!is.na(datos$language), ]

datos_tmp = datos

# Convert the datetime column to Date class (if it's not already)
datos_tmp$Date.submitted <- as.Date(datos_tmp$Date.submitted)
# Extract the year from the datetime column
datos_tmp$Years <- year(datos_tmp$Date.submitted)

datos_tmp=data.frame(Language=datos_tmp$Language,Year=datos_tmp$Year)
datos_tmp= datos_tmp %>% group_by(Language,Year) %>% summarize(n())
datos_tmp=data.frame(datos_tmp)

datos_tmp=datos_tmp[-c(12, 25), ]

# Create the barplot
g=ggplot(data=datos_tmp, aes(x=Year, y=n.., fill=Language)) +
  geom_bar(stat="identity") +
  scale_x_continuous(breaks = seq(2008, 2023, by = 1)) +
  theme_classic() + xlab("years") + ylab("# Submitted manuscripts (absolute frequency)") +
  scale_fill_brewer(palette=paleta) + ggtitle("Submissions by year according to their language")

ggplotly(g)
