# load data
data = read.csv("data/Credit.csv")
# Dummy vars
temp_data = model.matrix(Balance ~ ., data)
clean_data = cbind(temp_data[ ,-1], Balance = data[,12])
# mean centering and standardizing
scaled_data = scale(clean_data, center = TRUE, scale = TRUE)

####
# I will now scrable the data
# the first 300 observations are the training set
# the next 100 are the test set
###
set.seed(100)
scaled_data = scaled_data[sample(nrow(scaled_data)),]
x.train = data[1:300, 2:(ncol(data)-1)]
y.train = data[1:300, ncol(data)]
x.test = data[301:nrow(data), 2:(ncol(data)-1)]
y.test = data[301:nrow(data), ncol(data)]

# write data
write.csv(scaled_data, file = "data/scaled-credit.csv")
write.csv(x.train, file = "data/xtrain.csv")
write.csv(y.train, file = "data/ytrain.csv")
write.csv(x.test, file = "data/xtest.csv")
write.csv(y.test, file = "data/ytest.csv")










