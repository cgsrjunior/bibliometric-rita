library("dplyr")   #Ordenamiento de datos
library(knitr)
library(lubridate)


# Remember to change this for the next 
datos = read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/BD_RITA_ACCEPTADOS.csv",sep=",",header=T)

# Supondo que seus dados estejam armazenados em uma data frame chamada datos_tmp
datos <- datos %>%
  distinct(doc, .keep_all = TRUE)


#Filtro de artículos publicados
datos_tmp=data.frame(table(datos$year))
names(datos_tmp)[1]="Years"
datos_tmp$Freq_AC=cumsum(datos_tmp$Freq)

#Cálculo de ARG
ARG=rep(0,nrow(datos_tmp))
for (a in 2:nrow(datos_tmp))
{ARG[a]=round(((datos_tmp$Freq[a]-datos_tmp$Freq[a-1])/datos_tmp$Freq[a-1])*100,2)}
datos_tmp$AGR=ARG

#Cálculo CARG
carg = rep(0,nrow(datos_tmp))

for (a in 2:nrow(datos_tmp))
{carg[a]=((datos_tmp$Freq_AC[a]/datos_tmp$Freq[a])^(1/(a-1)))-1}
datos_tmp$CARG = (round(carg,4)*100)


#Cálculo de RGR
RGR = rep(0,nrow(datos_tmp))

for (a in 2:nrow(datos_tmp))
{RGR[a]=log(datos_tmp$Freq_AC[a])-log(datos_tmp$Freq_AC[a-1])}
datos_tmp$RGR = round(RGR,2)

#Cálculo de DT
datos_tmp$DT = round(0.603/datos_tmp$RGR,2)
datos_tmp$DT[1]=0

bibliometrics_calculated_table = knitr::kable(datos_tmp[,c(1:7)])

# Caminho do arquivo para salvar a tabela
caminho_arquivo <- "C:/Users/ntu_c/metadata-article-ml/rpubs-images/bibliometrics_calculated_table.md"
# Escrever o conteúdo da tabela no arquivo
writeLines(as.character(bibliometrics_calculated_table), caminho_arquivo)
# Mensagem de confirmação
cat(paste("Tabela salva em:", caminho_arquivo, "\n"))


# Authors bibliometric indexes calculate below here

datos_tmp2=data.frame(table(datos$doc))
datos_tmp2=merge(datos_tmp2,datos[,c("doc","year")],by.x="Var1",by.y="doc")
names(datos_tmp2)[1]=c("doc")
anos=sort(unique(datos_tmp2$year))
datos_tmp2=unique(datos_tmp2)

#Cálculo de AAPP and PPAA

AAPP= rep(0,length(anos))
for (a in 1:length(anos))
{
  #Denominador
  tmp=datos_tmp2[which(datos_tmp2$year==anos[a]),]
  deno = length(tmp$doc)
  
  #Numerador
  tmp2=datos$authors[which(datos$year==anos[a])]
  nume = length(unique(tmp2))
  AAPP[a] = round(nume/deno,2)
}
datos_tmp$AAPP = AAPP
datos_tmp$PPAA = round(1/AAPP,2)

# DC Index

DC= rep(0,length(anos))
for (a in 1:length(anos))
{tmp=datos_tmp2[which(datos_tmp2$year==anos[a]),]
N_m = length(which(tmp$Freq>1))
N_s = length(which(tmp$Freq==1))
DC[a] = round(N_m/(N_m+N_s),2)
}
datos_tmp$DC = DC

# CI Index

CI= rep(0,length(anos))

for (a in 1:length(anos))
{
  #Denominador
  tmp=datos_tmp2[which(datos_tmp2$year==anos[a]),]
  deno=length(tmp$Freq)
  
  #Numerador
  A = max(tmp$Freq)
  nume = 0
  for (j in 1:A)
  { nume = nume + j*length(which(tmp$Freq==j))}
  
  CI[a]=round(nume/deno,2)
}
datos_tmp$CI = CI

# CC Index

CC= rep(0,length(anos))

for (a in 1:length(anos))
{
  #Denominador
  tmp=datos_tmp2[which(datos_tmp2$year==anos[a]),]
  deno=length(tmp$Freq)
  
  #Numerador
  A = max(tmp$Freq)
  nume = 0
  for (j in 1:A)
  { nume = nume + (1/j)*length(which(tmp$Freq==j))}
  
  CC[a]=round(1-(nume/deno),2)
}
datos_tmp$CC = CC


# MCC Index

MCC= rep(0,length(anos))

for (a in 1:length(anos))
{
  #Denominador
  tmp=datos_tmp2[which(datos_tmp2$year==anos[a]),]
  deno=length(tmp$Freq)
  
  #Numerador
  A = max(tmp$Freq)
  nume = 0
  for (j in 1:A)
  { nume = nume + (1/j)*length(which(tmp$Freq==j))}
  
  MCC[a]=round((deno/(deno-1))*(1-(nume/deno)),2)
}
datos_tmp$MCC = MCC


datos = read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/BD_RITA_ACCEPTADOS.csv",sep=",",header=T)

anos = unique(datos$year)
PNA = rep(0,length(anos))
for (a in 1:length(anos))
{ deno=length(which(datos$year==anos[a]))
pag = datos$pages[which(datos$year==anos[a])]
pag = pag[which(pag!="-")]
nume=sum(as.numeric(pag))
PNA[a] = nume/deno
}
datos_tmp$PNA = round(PNA,2)

authors_indicators_table = knitr::kable(datos_tmp[,c(1,2,8:14)])


# --------------------- Testing the some hipotesis -------------------------------

# Average publications per year

#wilcox.test(x=datos_tmp$Freq,mu=mean(datos_tmp$Freq),alternative="two.sided")
t.test(x=datos_tmp$Freq,mu=mean(datos_tmp$Freq),alternative="two.sided")

# Resultados do teste t
mean_x <- 54.5
n <- 16
ci_lower <- 41.3048
ci_upper <- 67.6952
# Calcular a margem de erro
me <- ci_upper - mean_x
# Valor crítico t para 95% IC e 15 graus de liberdade
t_crit <- qt(0.975, df = 15)
# Calcular o erro padrão
se <- me / t_crit
# Calcular o desvio padrão
sd <- se * sqrt(n)
sd

#Average pages per publication

pag = as.numeric(datos$pages[which(datos$pages!="-")])
print(mean(pag))

t.test(x=pag,mu=mean(pag),alternative="two.sided")

# Resultados do teste t
mean_x <- 17.48968
n <- 872
ci_lower <- 16.94851
ci_upper <- 18.03084
# Calcular a margem de erro
me <- ci_upper - mean_x
# Valor crítico t para 95% IC e 15 graus de liberdade
t_crit <- qt(0.975, df = 871)
# Calcular o erro padrão
se <- me / t_crit
# Calcular o desvio padrão
sd <- se * sqrt(n)
sd

# Average views per publication

views = as.numeric(datos$Views[which(datos$Views!="none")])
views = views/(max(datos$year)-datos$year[which(datos$Views!="none")]+1)

t.test(x=views,mu=mean(views),alternative="two.sided")


# Resultados do teste t
mean_x <- 175.9748
n <- 872
ci_lower <- 153.2118
ci_upper <- 198.7379
# Calcular a margem de erro
me <- ci_upper - mean_x
# Valor crítico t para 95% IC e 15 graus de liberdade
t_crit <- qt(0.975, df = 871)
# Calcular o erro padrão
se <- me / t_crit
# Calcular o desvio padrão
sd <- se * sqrt(n)
sd
