# Data Analysis Script - Using all 5 regressions
install.packages("broom")
library(stargazer)
library(broom)
library(ggplot2)

load("./data/lm-model.RData")
load("./data/ridge-models.RData")
load("./data/lasso-models.RData")
load("./data/pcr-models.RData")
load("./data/pls-models.RData")


x = tidy(lassoModel)
y = tidy(ridgeModel)
tidy(linearModel)
stargazer(coef(lassoModel))
