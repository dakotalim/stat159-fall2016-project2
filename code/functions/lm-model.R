data = as.matrix(read.csv("data/scaled-credit.csv", row.names = 1))

# build linear model, dont use 'X' column
linearModel = lm(Balance ~ ., data)

# save as .RData file
save("linearModel", "data/lm-model.RData")
































