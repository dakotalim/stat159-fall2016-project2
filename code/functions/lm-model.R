data = read.csv("data/scaled-credit.csv")

# build linear model, dont use 'X' column
linearModel = lm(Balance ~ ., data[,2:ncol(data)])

# save as .RData file
save(linearModel, "data/lm-model.RData")
































