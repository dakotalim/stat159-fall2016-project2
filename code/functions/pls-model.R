# load data, separate into training and test sets 
# note that the data was randomized in pre-modeling-script.R
data = read.csv("data/scaled-credit.csv")
x.train = read.csv("data/xtrain.csv")
y.train = read.csv("data/ytrain.csv")
x.test = read.csv("data/xtest.csv")
y.test = read.csv("data/ytest.csv")

# uses pls package
install.packages("pls")
library(pls)

# cross validate pls model
set.seed(1)
plsCV = plsr(y.train ~ x.train, validation = "CV")

# get best model
bestPLS = plsCV$validation$PRESS

# Create plot of # components vs MSEP
png("images/plsCV-plot.png")
validationplot(plsCV, val.type = "MSEP")
dev.off()

# use test sets to get test MSE
y.pred = predict(plsCV, x.test, ncomp = 11)
squaredError = (y.test-y.pred)^2
cvPlsMSE = sum(squaredError)/length(squaredError)

# re-fit on FULL DATA
plsModel = plsr(Balance ~ ., data = data.frame(data[,2:ncol(data)]), scale = T, ncomp = 11)

# save CV output, best # pls components, and plsModel
save(c("plsModel", "bestPls", "plsCV"), "data/pls-models.RData")














