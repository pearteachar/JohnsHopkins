# Set working directory to location where R script is
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # Set working directory to where R script is saved
library("stringr")
library("dplyr")

# Part 1
pollutantmean <- function(directory, pollutant, id=1:332){
     numbers <- as.character(id) %>% str_pad(3, side="left", pad="0")
     to_read <- paste0(directory, "/", numbers, ".csv") %>% as.list()
     
     data <- lapply(to_read, function(X){
          read.csv(X) %>% select(pollutant) %>% na.omit()
     }) %>% unlist()
     
     mean(data)
}
