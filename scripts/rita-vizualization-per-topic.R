#Bibliotecas
library("quanteda")
# Carregar pacotes necessários
library(dplyr)
library(ggplot2)

#Lectura de datos
#Datos originales
datos=read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/BD_RITA_ACCEPTADOS.csv",sep=",",header=T)

# Remover duplicatas com base no campo 'title'
datos <- datos %>%
  dplyr::distinct(title, .keep_all = TRUE)

#Tesauro
thesaurus=read.csv("C:/Users/ntu_c/metadata-article-ml/dataset/IEEE_tesauro.csv",sep=";",header = T)
names(thesaurus)=c("Area1","Area2","Area3","Area4", "Area5", "Area6")

thesaurus_subareas=unique(thesaurus$Area4)

#Creación del corpus: los datos son convertidos a formato de corpus
corpus_datos = corpus(datos, text_field = "abstract")
#summary(corpus_datos,5)
#Tokenizatión: los datos son tokenizados, estandarizando el texto
toks_datos = tokens(corpus_datos,remove_punct = T,remove_symbols = T, remove_numbers = T, remove_url = T,
                    remove_separators = T)
#Convertir mayúsculas a minúsculas
toks_datos=tokens_tolower(toks_datos)

#Filtramos del tokenizado sólos las palabras similares a las subáreas del tesauro
kw_datos = kwic(toks_datos, pattern = phrase(thesaurus_subareas))
#Nos quedamos sólo con los elementos relevantes
kw_datos$from=kw_datos$from=kw_datos$to=kw_datos$pre=kw_datos$post=kw_datos$pattern=NULL
#Le agregamos a kw_datos los años
corpus_organizado=summary(corpus_datos,n=length(kw_datos$docname))
kw_datos=merge(kw_datos,corpus_organizado[,c("Text","year")],by.x="docname",by.y = "Text")

#Transfomación de kw en corpus
corpus_kw = corpus(kw_datos,text_field="keyword")
toks_datos_the = tokens(corpus_kw)
toks_datos_the = tokens_compound(toks_datos_the, pattern = phrase(thesaurus_subareas))
dfmat_datos_the = dfm(toks_datos_the)

thesaurus$Area4=tolower(thesaurus$Area4)
kw_datos2=merge(kw_datos,thesaurus[,c("Area2","Area4")],by.x="keyword",by.y="Area4")
corpus_kw = corpus(kw_datos2,text_field="Area2")
toks_datos_the = tokens(corpus_kw,remove_punct = T,remove_symbols = T, remove_numbers = T, remove_url = T,
                        remove_separators = T)
toks_datos_the = tokens_compound(toks_datos_the, pattern = phrase(thesaurus$Area2))
dfmat_datos_the = dfm(toks_datos_the)

names(kw_datos2)=c("keyword","docname","year","area")

# Remover duplicatas com base no campo 'title'
kw_datos2 <- kw_datos2 %>%
  dplyr::distinct(docname, .keep_all = TRUE)

# Passo 1: Criar lista de áreas únicas
areas_unicas <- unique(kw_datos2$area)
kw_area <- data.frame(area = areas_unicas, views = 0)

#Filtro por año. También debe incluir la opción ALL
ano="2023"
acumulado = F

# Filter per year
if (acumulado==F) {datos=datos[which(datos$year==ano),]} else
{datos=datos[which(datos$year<=ano),]} 

# Passo 2: Percorrer o dataframe datos e atualizar as contagens de views
for (i in seq_len(nrow(datos))) {
  abstract <- datos$abstract[i]
  
  # Verificar se alguma keyword está presente no abstract
  for (j in seq_len(nrow(kw_datos2))) {
    keyword <- kw_datos2$keyword[j]
    area <- kw_datos2$area[j]
    
    # Verificar se a keyword está presente no abstract
    if (grepl(keyword, abstract, ignore.case = TRUE)) {
      # Encontrou uma correspondência, atualizar views na área correspondente
      idx <- which(kw_area$area == area)
      kw_area$views[idx] <- kw_area$views[idx] + datos$View[i]
    }
  }
}

# Filtrar kw_area para remover áreas com nome em branco
kw_area_filtrado <- kw_area[kw_area$area != "", ]

# Ordenar kw_area_filtrado em ordem decrescente por views
kw_area_filtrado <- kw_area_filtrado[order(-kw_area_filtrado$views), ]

# Converter 'area' para um fator ordenado pela contagem de views
kw_area_filtrado$area <- factor(kw_area_filtrado$area, levels = kw_area_filtrado$area)

# Remover a linha que contém "Humanities" de kw_area_filtrado
kw_area_filtrado <- subset(kw_area_filtrado, area != "Humanities")

# Gerar gráfico de barras
g1 = ggplot(kw_area_filtrado, aes(x = area, y = views)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "View count per area", x = "Área", y = "Número de Views") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

library(knitr)
# Selecionar os top 10 documentos mais visitados
top_n_articles <- head(kw_area_filtrado, 10)
# Gerar tabela Markdown com os top 10 areas mais vistas
table_ranked_area <- kable(top_n_articles, caption = "Top 10 Areas Viewed", align = "c", row.names = FALSE)

