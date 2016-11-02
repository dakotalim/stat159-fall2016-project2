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

# cross validate lasso model
set.seed(1)
grid = 10^seq(10, -2, length = 100)
lassoCV = cv.glmnet(x.test, y.test, alpha = 1, intercept = F, standardize = F,
                    lambda = grid)


# select best model
bestLassoLambda = lassoCV$lambda.min

# plot errors in terms of lambda
png("images/lassoCV-plot.png")
plot(lassoCV)
dev.off()

# Use CV'ed lambda value on the test sets to get cvLassoMSE (test MSE)
y.pred = predict(lassoCV, x.test, s = bestLassoLambda)
squaredError = (y.test - y.pred)^2
cvLassoMSE = sum(squaredError)/length(squaredError)

# Re-fit on FULL DATA using bestLassoLambda
lassoModel = glmnet(data[,1:(ncol(data) - 1)], data[,ncol(data)], standardize = F,
                    intercept = F, lambda = bestLassoLambda)

# save CV output, optimal lambda, and the full model
save(lassoModel, lassoCV, bestLassoLambda, cvLassoMSE, file = "data/lasso-models.RData")



