library("stringr")    #Contiene las funciones para manejo de cadenas de texto

# Lectura de datos originales
data=read.csv("D:/metadata-article-ml/dataset/BD_17_11_2023.csv",sep=",",header=T)

# Remover campos vacíos o incompletos\

# Get column names that contain the substring desired to remove
# Identify columns with all missing values
id_columns <- grep("ID", names(data), value = TRUE)
empty_columns <- colSums(is.na(data)) == nrow(data)
email_columns <- grep("Email", names(data), value = TRUE)
orcid_columns <- grep("ORCID", names(data), value = TRUE)
url_columns <- grep("URL", names(data), value = TRUE)
biostatement_columns <- grep("Bio.Statement", names(data), value = TRUE)


# Remove the identified columns
data <- data[, !empty_columns]
data <- data[, !names(data) %in% email_columns]
data <- data[, !names(data) %in% orcid_columns]
data <- data[, !names(data) %in% url_columns]
data <- data[, !names(data) %in% id_columns]
data <- data[, !names(data) %in% biostatement_columns]

# Remove rows with blank values in the "title" or "abstract" columns
data <- data[!(data$Title == "" | data$Abstract == "" | data$Country..Author.1. == ""), ]

