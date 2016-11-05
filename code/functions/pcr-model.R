#' @Title PCR Model
#' @param data taken after eda-script is run
#' @return data/pcr-models.RData
#'
# Script to run the PRINCIPLE COMPONENT ANALYSIS Regression.

library(pls)

# load data, separate into training and test sets 
# note that the data was randomized in pre-modeling-script.R
data = as.matrix(read.csv("data/scaled-credit.csv", row.names = 1))
x.train = as.matrix(read.csv("data/xtrain.csv", row.names = 1))
y.train = as.matrix(read.csv("data/ytrain.csv", row.names = 1))
x.test = as.matrix(read.csv("data/xtest.csv", row.names = 1))
y.test = as.matrix(read.csv("data/ytest.csv", row.names = 1))

# cross validate pls model
set.seed(1)
pcrCV = pcr(y.train ~ x.train, scale = FALSE, validation = "CV")

bestPCR = pcrCV$validation$PRESS
bestPCR = which(bestPCR == min(bestPCR))

# Create plot of # components vs MSEP
png("images/pcrCV-plot.png")
validationplot(pcrCV, val.type = "MSEP", main = "PCR CV-Component MSEP")
dev.off()

# use test sets to get test MSE
y.pred = as.matrix(predict(pcrCV, x.test, ncomp = bestPCR))
squaredError = (y.test-y.pred)^2
cvPcrMSE = sum(squaredError)/length(squaredError)

# re-fit on FULL DATA
pcrModel = pcr(Balance ~ ., data = data.frame(data[,1:ncol(data)]), scale = F, ncomp = bestPCR)

# save CV output, best # pls components, and plsModel
save(pcrModel, bestPCR, pcrCV, cvPcrMSE, file = "data/pcr-models.RData")

