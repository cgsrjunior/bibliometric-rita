# Carregar pacotes necessários
library(dplyr)
library(tidyr)

# Ler o CSV
file_path <- "/cloud/project/dataset/ieee-taxonomy-formated.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

# Identificar a linha problemática
linha_problematica <- 373

# Separar os valores da linha problemática em múltiplas linhas
# Aqui assumimos que a linha problemática é a 373
valores_separados <- strsplit(as.character(data[linha_problematica, ]), "\n")[[1]]

# Criar um novo data frame com os valores separados
data_separada <- data.frame(matrix(ncol = ncol(data), nrow = length(valores_separados)))
colnames(data_separada) <- colnames(data)

# Preencher o novo data frame com os valores separados
data_separada[1, ] <- data[linha_problematica, ]
data_separada[1:length(valores_separados), 1] <- valores_separados

# Adicionar as outras linhas do data frame original
data_final <- bind_rows(data[1:(linha_problematica-1), ], data_separada, data[(linha_problematica+1):nrow(data), ])

# Visualizar o resultado
print(data_final)

# Salvar o novo DataFrame em um novo arquivo CSV
write.csv(data_final, "seu_arquivo_corrigido.csv", row.names = FALSE)
