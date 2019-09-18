#Load required libraries
library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/sdc-somalia_needs_assessment_microdataV2")
data <- read_excel("data.xlsx", sheet = "Feuil1", 
                   col_types = c("text", "text", "text", 
                                 "text", "numeric", "text", "text", 
                                 "text", "text", "text", "numeric", 
                                 "text", "numeric"))


#Select key variables                   
selectedKeyVars <- c('idp_settlement', 
                     'resp_gender',	'resp_age',
                     'breadwinner',	
                     'total_hh',	'person_with_disabilities'
)

#select weights
weightVars <- c('weights_general')

#Convert variables into factors
cols =  c('idp_settlement',	'settlement',
          'resp_gender',	'resp_age',
          'breadwinner',	
          'total_hh',	'person_with_disabilities')

data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into a dataframe
subVars <- c(selectedKeyVars, weightVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)
objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars, weightVar = weightVars
                       )

#print the risk
print(objSDC, "risk")
max(objSDC@risk$global[, "risk"])

#Generate an internal (extensive) report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 


