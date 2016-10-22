# load data
data = read.csv("data/Credit.csv")

# separate into qualitative & quantitative, data[,1] is an index column
quantitativeCol = data[,c(2:7,12)]
qualitativeCol = data[,8:11]

# Quantitative analysis
sink("data/eda-quantitative-output.txt")
"Minimum, Q1, Median, Mean, Q3, and Max of all quantitative predictors"
summary(quantitativeCol)
"IQR of all quantitative predictors"
apply(quantitativeCol, 2, FUN=IQR)
"Standard Deviation of all quantitative predictors"
apply(quantitativeCol, 2, FUN=sd)
sink()

png("images/income-plots.png")
hist(quantitativeCol[,1], main = "Histogram of Income", xlab = "Income")
boxplot(quantitativeCol[,1], horizontal = T, main = "Boxplot of Income")
dev.off

png("images/limit-plots.png")
hist(quantitativeCol[,2], main = "Histogram of Limit", xlab = "Limit")
boxplot(quantitativeCol[,2], horizontal = T, main = "Boxplot of Limit")
dev.off

png("images/rating-plots.png")
hist(quantitativeCol[,3], main = "Histogram of Rating", xlab = "Rating")
boxplot(quantitativeCol[,3], horizontal = T, main = "Boxplot of Rating")
dev.off

png("images/cards-plots.png")
hist(quantitativeCol[,4], main = "Histogram of Cards", xlab = "Cards")
boxplot(quantitativeCol[,4], horizontal = T, main = "Boxplot of Cards")
dev.off

png("images/age-plots.png")
hist(quantitativeCol[,5], main = "Histogram of Age", xlab = "Age")
boxplot(quantitativeCol[,5], horizontal = T, main = "Boxplot of Age")
dev.off

png("images/education-plots.png")
hist(quantitativeCol[,6], main = "Histogram of Education", xlab = "Education")
boxplot(quantitativeCol[,6], horizontal = T, main = "Boxplot of Education")
dev.off

png("images/balance-plots.png")
hist(quantitativeCol[,7], main = "Histogram of Balance", xlab = "Balance")
boxplot(quantitativeCol[,7], horizontal = T, main = "Boxplot of Balance")
dev.off

# Qualitative Analysis, uses plyr, gridExtra, MASS packages

install.packages('plyr')
library(plyr)
install.packages('gridExtra')
library(gridExtra)
install.packages('MASS')
library(MASS)

genderF = count(qualitativeCol, 'Gender')
studentF = count(qualitativeCol, 'Student')
marriedF = count(qualitativeCol, 'Married')
ethnicityF = count(qualitativeCol, 'Ethnicity')
genderRF = genderF[,2]/sum(genderF[,2])
studentRF = studentF[,2]/sum(studentF[,2])
marriedRF = marriedF[,2]/sum(marriedF[,2])
ethnicityRF = ethnicityF[,2]/sum(ethnicityF[,2])


png("images/gender-freq.png")
grid.table(cbind(genderF, "rel-freq"= genderRF))
dev.off()

png("images/student-freq.png")
grid.table(cbind(studentF, "rel-freq"= studentRF))
dev.off()

png("images/married-freq.png")
grid.table(cbind(marriedF, "rel-freq"= marriedRF))
dev.off()

png("images/ethnicity-freq.png")
grid.table(cbind(ethnicityF, "rel-freq"= ethnicityRF))
dev.off()

png("images/gender-counts-barplot.png")
barplot(table(qualitativeCol[,1]), ylim = c(0,250))
dev.off()

png("images/student-counts-barplot.png")
barplot(table(qualitativeCol[,2]), ylim = c(0,400))
dev.off()

png("images/married-counts-barplot.png")
barplot(table(qualitativeCol[,3]), ylim = c(0,250))
dev.off()

png("images/ethnicity-counts-barplot.png")
barplot(table(qualitativeCol[,4]), ylim = c(0,250))
dev.off()


# Balance analysis, uses corrplot package
install.packages('corrplot')
library(corrplot)

png("images/quant-corr-matrix.png")
grid.table(round((cor(quantitativeCol)), 3))
dev.off()

png("images/quant-scatterplot.png")
pairs(quantitativeCol)
dev.off()

# Build ANOVA models for Balance ~ (each quantitative predictor)
incomeAOV = aov(Balance ~ Income, quantitativeCol)
limitAOV = aov(Balance ~ Limit, quantitativeCol)
ratingAOV = aov(Balance ~ Rating, quantitativeCol)
cardsAOV = aov(Balance ~ Cards, quantitativeCol)
ageAOV = aov(Balance ~ Age, quantitativeCol)
educationAOV = aov(Balance ~ Education, quantitativeCol)

# save as .RData
models = c(incomeAOV, limitAOV, ratingAOV, cardsAOV, ageAOV, educationAOV, balanceAOV)
save(models, "data/aov.RData")


# conditional boxplots 
png("images/gender-boxplot.png")
boxplot(Balance ~ Gender, data, main = "Gender Boxplot", ylab ="Balance")
dev.off()

png("images/student-boxplot.png")
boxplot(Balance ~ Student, data, main = "Student Boxplot", ylab ="Balance")
dev.off()

png("images/married-boxplot.png")
boxplot(Balance ~ Married, data, main = "Married Boxplot", ylab ="Balance")
dev.off()

png("images/ethnicity-boxplot.png")
boxplot(Balance ~ Ethnicity, data, main = "Ethnicity Boxplot", ylab ="Balance")
dev.off()














