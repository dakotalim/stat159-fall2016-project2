data = as.matrix(read.csv("data/scaled-credit.csv", row.names = 1))
x.train = as.matrix(read.csv("data/xtrain.csv", row.names = 1))
y.train = as.matrix(read.csv("data/ytrain.csv", row.names = 1))
x.test = as.matrix(read.csv("data/xtest.csv", row.names = 1))
y.test = as.matrix(read.csv("data/ytest.csv", row.names = 1))

# build linear model, dont use 'X' column
linearModel = lm(y.train ~ x.train)
linearMSE = sum(linearModel$residuals^2)/length(linearModel$residuals)


# save as .RData file
save(linearModel, linearMSE, file = "data/lm-model.RData")
































