library("stringr")    #Contiene las funciones para manejo de cadenas de textotrace

printParameters <- function(v_line, v_column, v_word, v_current_path, v_result_dict) {
  # Print the variables
  cat("Line:", v_line, "\n")
  cat("Column:", v_column, "\n")
  cat("Word:", v_word, "\n")
  print("Current Path:\n")
  print(v_current_path)
  print("\nResult Dict:\n")
  print(v_result_dict)
  print("\n")
}


# Lectura de datos originales
data_frame=read.table("C://Users/ntu_c/metadata-article-ml/dataset/ieee-taxonomy.txt",sep="\t",header=F)

column_names <- c("Col1", "Col2", "Col3", "Col4", "Col5", "Col6")
dict_names <- c("Term1", "Term2", "Term3", "Term4", "Term5", "Term6")

#Initialize variables
result_dict = data.frame(data.frame(matrix(ncol = length(dict_names), nrow = 0)))
num_spaces = 0

current_path = data.frame(data.frame(matrix(ncol = length(column_names), nrow = 0)))

# Set column names
colnames(result_dict) <- dict_names
colnames(current_path) <- column_names

# Add the first empty row
current_path = rbind(current_path, rep(NA, length(column_names)))

#We going to fill the matrix using the following format
# result_dict[i,j]
# Where i line, j column
column=1

for (i in 1:nrow(data_frame)){
  word = data_frame[i, ]
  # Check if the character "world" is contained in the variable
  if ((substr(word, 1, 1) == ".")) {
    
    # Need to remove the dot to not interfere in the space count
    # Remove the first character
    word = substring(word, 2)
    
    # Need to acumulate a path and swap some positions where necessary
    # Count the number of spaces at the beginning of the string
    num_spaces = 0
    ascii_char_vec = charToRaw(word)
    
    # For to count the space chars
    for(j in 1:length(ascii_char_vec)){
      if(as.numeric(ascii_char_vec[j]) == 32){
        num_spaces = num_spaces + 1
      } else {
        num_spaces = num_spaces + 1  
        break
      }
    }
    
    
    if(num_spaces > 6){
      print("Need to add a new column")
      print("iteration:")
      print(i)
      print("Number of spaces:")
      print(num_spaces)
    }
    
    #printParameters(line,column,word,current_path,result_dict)
    
    # Need to clean the spaces and sp chars on the left of the sentence
    # Remove spaces and special characters before the first letter
    word = gsub("^[^A-Za-z0-9]*", "", word)
    
    
    
    if(num_spaces == column){
      
      # If the next value was on the same level, we only need to replace the last value
      # and add a new row
      current_path[,column] = word
      result_dict = rbind(result_dict, current_path)
      
    } else {
      
      # We verify if we add a new column value by checking if the value increase
      if(num_spaces > column){
        
          # Update the path for the rows intermediary insertion
          column = column + 1
          
          # We update this for facilitate a copy when insert a next line
          current_path[, column] = word
          
          # Adding the new value on the resultant dict
          result_dict = rbind(result_dict, current_path)
          
          
          
      } else {
        
        while (column != num_spaces){
          # Remove or "pop" the last column
          current_path[, column] = ""
          column = column - 1
        }
        
        # Put the new word in the appropriate position
        current_path[,column] = word
        
        # Add a new line to the entry
        result_dict = rbind(result_dict, current_path)

      }
    }
    
    
  } else {
    
    #Clean the current path for the insertion of the new level
    for(k in 1:ncol(current_path)){
      current_path[,k] = ""
    }
    current_path[,1] = word
  }
  
}

#result_dict = result_dict[-1,]
write.table(result_dict,"C://Users/ntu_c/metadata-article-ml/dataset/IEEE_tesauro.csv",sep=";",row.names=F,quote = F)