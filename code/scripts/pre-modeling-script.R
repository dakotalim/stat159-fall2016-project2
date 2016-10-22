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

# write data
write.csv(scaled_credit, file = "data/scaled-credit.csv")














