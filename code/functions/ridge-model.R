# uses glmnet package
install.packages("glmnet")
library(glmnet)

# load data, separate into training and test sets 
# note that the data was randomized in pre-modeling-script.R
data = as.matrix(read.csv("data/scaled-credit.csv", row.names = 1))
x.train = as.matrix(read.csv("data/xtrain.csv", row.names = 1))
y.train = as.matrix(read.csv("data/ytrain.csv", row.names = 1))
x.test = as.matrix(read.csv("data/xtest.csv", row.names = 1))
y.test = as.matrix(read.csv("data/ytest.csv", row.names = 1))

# cross validate ridge model
set.seed(1)
grid = 10^seq(10, -2, length = 100)
ridgeCV = cv.glmnet(x.test, y.test, alpha = 0, intercept = F, standardize = F,
                    lambda = grid)


# select best model
bestRidgeLambda = ridgeCV$lambda.min

# plot errors in terms of lambda
png("images/ridgeCV-plot.png")
plot(ridgeCV)
dev.off()

# Use CV'ed lambda value on the test sets to get cvRidgeMSE (test MSE)
y.pred = predict(ridgeCV, x.test, s = bestRidgeLambda)
squaredError = (y.test - y.pred)^2
cvRidgeMSE = sum(squaredError)/length(squaredError)

# Re-fit on FULL DATA using bestRidgeLambda
ridgeModel = glmnet(data[,2:(ncol(data) - 1)], data[,ncol(data)], standardize = F,
                      intercept = F, lambda = bestRidgeLambda)

# save CV output, optimal lambda, and the full model
save(ridgeModel, ridgeCV, bestRidgeLambda, cvRidgeMSE, file = "data/ridge-models.RData")
























