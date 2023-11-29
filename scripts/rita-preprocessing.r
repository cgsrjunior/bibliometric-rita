library("stringr")    #Contiene las funciones para manejo de cadenas de texto

# Lectura de datos originales
data=read.csv("D:/metadata-article-ml/dataset/BD_17_11_2023.csv",sep=",",header=T)

#Let's using a copy for comparison purposes
data_filtered = data

# Remover campos vacíos o incompletos\
# Get column names that contain the substring desired to remove
# Identify columns with all missing values
id_columns <- grep("ID", names(data_filtered), value = TRUE)
email_columns <- grep("Email", names(data_filtered), value = TRUE)
homepage_columns <- grep("Homepage", names(data_filtered), value = TRUE)
biostatement_columns <- grep("Bio.Statement..e.g", names(data_filtered), value = TRUE)
url_columns <- grep("URL", names(data), value = TRUE)
biostatement_columns <- grep("Bio.Statement", names(data), value = TRUE)

#Gather the empty columns to cleanup
columns_checkup <- colSums(is.na(data_filtered)) == nrow(data_filtered)
empty_columns <- names(columns_checkup[columns_checkup])

# Check each column for missing values and analyse which ones is essential
missing_value_flags <- sapply(data_filtered, function(x) any(is.na(x) | x == ""))
missing_value_columns <- names(missing_value_flags[missing_value_flags])


# Remove the identified columns
data_filtered <- data_filtered[, !names(data_filtered) %in% id_columns]
data_filtered <- data_filtered[, !names(data_filtered) %in% email_columns]
data_filtered <- data_filtered[, !names(data_filtered) %in% homepage_columns]
data_filtered <- data_filtered[, !names(data_filtered) %in% biostatement_columns]
data_filtered <- data_filtered[, !names(data_filtered) %in% empty_columns]


#Identify columns to apply separators removal
affiliation_columns <- grep("Affiliation", names(data_filtered), value = TRUE)

# Remove rows with blank values in the "title" or "abstract" columns
data_filtered <- data_filtered[!(data_filtered$Title == "" | data_filtered$Abstract == "" | data_filtered$Country..Author.1. == ""), ]

#Remove separators from the abstract
data_filtered$Abstract=str_remove_all(data_filtered$Abstract,"\n")
data_filtered$Abstract=str_remove_all(data_filtered$Abstract,";")
data_filtered$Abstract=str_remove_all(data_filtered$Abstract,"|")
data_filtered$Abstract=str_remove_all(data_filtered$Abstract,"\r")


#Way to apply this to a group of columns
for (col in affiliation_columns) {
  data_filtered[[col]] <- gsub("[\r\n|;]", "", data_filtered[[col]])
}


#Saving Files
write.table(data_filtered,file="D:/metadata-article-ml/dataset/BD_RITA01.csv",quote = F,row.names = F,sep=";")
