library("ggplot2") #Gráficos
library("plotly")  #Gráficos
library("dplyr")   #Ordenamiento de datos
library(knitr)
library(lubridate)
library(scales)  # Para usar a função comma()

paleta = "Blues" #"Blues" "Zissou" "GrandBudapest"

# Remember to change this for the next 
datos = read.csv("/cloud/project/dataset/BD_RITA_ACCEPTADOS.csv",sep=",",header=T)

#Using distinct ID to gather only the absolute number of visualization each year
datos_tmp = distinct(datos, title, .keep_all = TRUE)

# Remover duplicatas e calcular as visitações totais por documento
articles_view_ranked <- datos_tmp %>%
  group_by(title) %>%
  arrange(desc(Views))


# Selecionar os top 10 documentos mais visitados
top_n_docs <- head(articles_view_ranked, 20)

# Selecionar apenas as colunas de interesse
top_n_docs <- top_n_docs[, c("authors", "title", "Views", "year")]

colnames(top_n_docs)[1] <- "author"

# Gerar tabela Markdown com os top 10 documentos mais visitados
table_ranked_article <- kable(top_n_docs, format = "markdown")


# Calcular a soma das visualizações por ano
datos_tmp <- datos_tmp %>%
  group_by(year) %>%
  summarise(sum_views = sum(Views))

datos_tmp=data.frame(datos_tmp)

g <- ggplot(datos_tmp, aes(x = factor(year), y = sum_views)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(x = "Year", y = "Total views") +
  ggtitle("Article Views Aggregated by year") +
  theme_minimal() +
  scale_y_continuous(labels = comma)  # Formatação para vírgulas nos milhares

ggplotly(g)

# Caminho do arquivo para salvar a tabela
caminho_arquivo <- "/cloud/project/rpubs-images/tabela_top_10_docs.md"
# Escrever o conteúdo da tabela no arquivo
writeLines(as.character(table_ranked_article), caminho_arquivo)
# Mensagem de confirmação
cat(paste("Tabela salva em:", caminho_arquivo, "\n"))
