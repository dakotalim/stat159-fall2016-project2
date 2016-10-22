# load data, separate into training and test sets 
# note that the data was randomized in pre-modeling-script.R
data = read.csv("data/scaled-credit.csv")
x.train = data[1:300, 2:(ncol(data)-1)]
y.train = data[1:300, ncol(data)]
x.test = data[301:nrow(data), 2:(ncol(data)-1)]
y.test = data[301:nrow(data), ncol(data)]

# uses glmnet package
install.packages("glmnet")
library(glmnet)

# build ridge model
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
save(c("ridgeModel", "ridgeCV", "bestRidgeLambda"), "data/ridge-models.RData")
























