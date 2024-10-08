#*******************************************************************************
#* Disclaimer: this code is an modified version of the following code cited below
#* 
#*    Title: Bibliometric analysis of published research in Revista
#*           de Informática Teórica e Aplicada (RITA) from 2008 to 2021
#*    Author: M Villalobos-Cid
#*    Date: 2023
#*    Code version: 1.0
#*    Availability: https://rpubs.com/mvillalobos/Rita
#*
#*******************************************************************************

library("stringr")    #Contiene las funciones para manejo de cadenas de texto
library("stringdist")
library("parallel")

# Lectura de datos originales
data=read.csv("/cloud/project/dataset/BD_17_11_2023.csv",sep=",",header=T, row.names = NULL)

#Fix header names error

#Let's using a copy for comparison purposes
data_filtered = data

# Remover campos vacíos o incompletos
# Get column names that contain the substring desired to remove
# Identify columns with all missing values
id_columns <- grep("ORCID", names(data_filtered), value = TRUE)
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

colunas = NULL

#Laço para remover separadores de todos os campos relacionados a Affiliation Author
for (i in 1:25) {
  # Construa o nome do campo
  field_name <- paste0("Affiliation..Author.", i, ".")
  
  # Aplique o comando completo para remover "\n" de cada campo correspondente
  data_filtered[[field_name]] <- str_remove_all(data_filtered[[field_name]], "\n")
  data_filtered[[field_name]] <- str_remove_all(data_filtered[[field_name]], ";")
  data_filtered[[field_name]] <- str_remove_all(data_filtered[[field_name]], "|")
  data_filtered[[field_name]] <- str_remove_all(data_filtered[[field_name]], "\r")
  
  #data_filtered[[field_name]] <- padronizar_nomes(data_filtered[[field_name]])
  #if(is.null(colunas))
  #  colunas = c(field_name)
  #else
  #  colunas = c(colunas, field_name)
}

#Remove separators from the Type
data_filtered$Type=str_remove_all(data_filtered$Type,"\n")
data_filtered$Type=str_remove_all(data_filtered$Type,";")
data_filtered$Type=str_remove_all(data_filtered$Type,"|")
data_filtered$Type=str_remove_all(data_filtered$Type,"\r")

#Remove separators from the Disciplines
data_filtered$Disciplines=str_remove_all(data_filtered$Disciplines,"\n")
data_filtered$Disciplines=str_remove_all(data_filtered$Disciplines,";")
data_filtered$Disciplines=str_remove_all(data_filtered$Disciplines,"|")
data_filtered$Disciplines.=str_remove_all(data_filtered$Disciplines,"\r")


#Remove separators from the Keywords
data_filtered$Keywords=str_remove_all(data_filtered$Keywords,"\n")
data_filtered$Keywords=str_remove_all(data_filtered$Keywords,";")
data_filtered$Keywords=str_remove_all(data_filtered$Keywords,"|")
data_filtered$Keywords=str_remove_all(data_filtered$Keywords,"\r")

#Remove separators from the Supporting Agencies
data_filtered$Supporting.Agencies=str_remove_all(data_filtered$Supporting.Agencies,"\n")
data_filtered$Supporting.Agencies=str_remove_all(data_filtered$Supporting.Agencies,";")
data_filtered$Supporting.Agencies=str_remove_all(data_filtered$Supporting.Agencies,"|")
data_filtered$Supporting.Agencies=str_remove_all(data_filtered$Supporting.Agencies,"\r")

#Way to apply this to a group of columns
for (col in affiliation_columns) {
  data_filtered[[col]] <- gsub("[\r\n|;]", "", data_filtered[[col]])
}


#Saving Files
write.table(data_filtered,file="/cloud/project/dataset/BD_RITA01.csv",quote = F,row.names = F,sep=";")
