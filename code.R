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
                   
selectedKeyVars <- c(
                     'resp_gender',	'resp_age',
                     'breadwinner'	
                     
)

weightVars <- c('weights_general')

#Convert variables into factors
cols =  c('idp_settlement',	'settlement',
          'resp_gender',	'resp_age',
          'breadwinner',	
          'total_hh',	'person_with_disabilities')

data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into dataframe
subVars <- c(selectedKeyVars, weightVars)
fileRes<-data[,subVars]
fileRes <- as.data.frame(fileRes)
objSDC <- createSdcObj(dat = fileRes, 
                       keyVars = selectedKeyVars, weightVar = weightVars
                       )

print(objSDC, "risk")

#Generate an internal report
report(objSDC, filename = "index",internal = T, verbose = TRUE) 
#max(objSDC@risk$global[, "risk"])
#objSDC@risk$individual

