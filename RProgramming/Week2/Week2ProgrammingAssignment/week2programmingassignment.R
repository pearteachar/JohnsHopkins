# Set working directory to location where R script is
setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # Set working directory to where R script is saved
library("stringr")
library("dplyr")

# Part 1
pollutantmean <- function(directory, pollutant, id){
     numbers <- as.character(id) %>% str_pad(3, side="left", pad="0")
     to_read <- paste0(directory, "/", numbers, ".csv") %>% as.list()

     data <- lapply(to_read, function(X){
          read.csv(X) %>% select(pollutant) %>% na.omit()
     }) %>% unlist()
     
     mean(data)
}

print(pollutantmean("specdata", "sulfate", 1:10))
# 4.064128

print(pollutantmean("specdata", "nitrate", 70:72))
#1.706047

print(pollutantmean("specdata", "nitrate", 23))
#1.2808322


# Part 2
complete <- function(directory, id){
  
  
}


# Part 3