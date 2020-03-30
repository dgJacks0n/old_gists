# testing retrieval of TCGA brteast PAM50
library(TCGAbiolinks)
library(dplyr)
library(reshape2) # for cross-tabs


# dataSubt  includes PAM50, ER, PR and HER2
dataSubt <- TCGAquery_subtype(tumor = "BRCA")

# get clinical data
dataClin <- GDCquery_clinic(project = "TCGA-BRCA","clinical") 


# summarize
xtab <- dcast(filter(dataSubt, !is.na(PAM50.mRNA)), 
      ER.Status + PR.Status + HER2.Final.Status ~ PAM50.mRNA,
      value.var = "patient", margins = TRUE, fun.aggregate = length)
