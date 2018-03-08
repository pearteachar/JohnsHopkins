# Set working directory to location where R script is
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # Set working directory to where R script is saved
library("stringr")
library("dplyr")

corr <- function(directory, threshold=1){
     # Get list of ids that meet the threshold     
     id_threshold <- complete(directory, 1:332) %>% filter(nobs >= threshold) %>%
          select(id) %>% unlist()
 
     if(length(id_threshold) == 0){     # Check if no monitors meet threshold
          vector('numeric', length=0)
     }else{
          # Compute cor of pollutants from threshold ids
          numbers <- as.character(id_threshold) %>% str_pad(3, side="left", pad="0")
          to_read <- paste0(directory, "/", numbers, ".csv") %>% as.list()
     
          valid <- lapply(to_read, function(X){
               cor_coeff <- read.csv(X) %>% select(nitrate, sulfate) %>% na.omit() %>% cor()
               cor_coeff[1,2]
          })
          unlist(valid)
     }
}
