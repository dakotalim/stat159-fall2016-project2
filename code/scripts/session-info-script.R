# Script to record information about the session.

library(pls)
library(glmnet)
library(plyr)
library(gridExtra)
library(MASS)
library(corrplot)
library(devtools)
library(knitr)
library(rmarkdown)
library(xtable)
library(ggplot2)

sink("./../../session-info.txt", append = TRUE)
cat("Session Information\n\n")
sessionInfo()
devtools::session_info()
sink()
