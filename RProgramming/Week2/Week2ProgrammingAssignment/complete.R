# Set working directory to location where R script is
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # Set working directory to where R script is saved
library("stringr")
library("dplyr")

complete <- function(directory, id){
     # Make file opener
     numbers <- as.character(id) %>% str_pad(3, side="left", pad="0")
     to_read <- paste0(directory, "/", numbers, ".csv") %>% as.list()
     
     # Make dataframe with two columns id and nobs, filtering NAs out
     data <- lapply(to_read, function(X){
          read.csv(X) %>% na.omit() %>% nrow()
     })
     do.call(rbind, Map(data.frame, id=id, nobs=data))
}

