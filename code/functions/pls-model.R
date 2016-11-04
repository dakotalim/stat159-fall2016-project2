# Script to run the PARTIAL LEAST SQUARES Regression.

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
plsCV = plsr(y.train ~ x.train, scale = F, validation = "CV")

# get best model
bestPLS = plsCV$validation$PRESS
bestPLS = which(bestPLS == min(bestPLS))

# Create plot of # components vs MSEP
png("images/plsCV-plot.png")
validationplot(plsCV, val.type = "MSEP", main = "PLS CV-Component MSEP")
dev.off()

# use test sets to get test MSE
y.pred = as.matrix(predict(plsCV, x.test, ncomp = bestPLS))
squaredError = (y.test-y.pred)^2
cvPlsMSE = sum(squaredError)/length(squaredError)

# re-fit on FULL DATA
plsModel = plsr(Balance ~ ., data = data.frame(data[,1:ncol(data)]), scale = F, ncomp = bestPLS)

# save CV output, best # pls components, and plsModel
save(plsModel, bestPLS, plsCV, cvPlsMSE, file = "data/pls-models.RData")

