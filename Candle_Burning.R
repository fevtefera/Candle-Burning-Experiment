# Import Candle Data 
candles <- read.csv('Candles.csv', stringsAsFactors = TRUE)
str(candles)

# Create Parallel Box Plots for a brief Exploratory Analysis
boxplot(length ~ type, data = candles, main = "Box Plots of Length by Type",
        xlab = 'Type', ylab = 'Length')

#Numerical Summary statistics of candle length for the whole data
length(candles$length)
mean(candles$length)
median(candles$length)
sd(candles$length)

# Numerical Summary Statistics of candle length  for Each Group
aggregate(length ~ type, data = candles, length)
aggregate(length ~ type, data = candles, mean)
aggregate(length ~ type, data = candles, median)
aggregate(length ~ type, data = candles, sd)

# Perform One-way ANOVA
candle.aov <- aov(length ~ type, data = candles)
anova(candle.aov)

# Assess Normality Assumption using Q-Q Plot of Residuals
qqnorm(residuals(candle.aov), main = "Normal Q-Q Plot of Residuals")
qqline(residuals(candle.aov))

# Obtain P-Value from Shapiro-Wilk Test
residuals <- residuals(candle.aov)
shapiro.test(residuals)

# Assess Homoscedasticity Assumption using Residual against Fitted Values plot
plot(residuals(candle.aov) ~ fitted.values(candle.aov), 
     main = "Residuals vs. Fitted Values", 
     xlab = "Fitted Values", ylab = "Residuals")
abline(h = 0, col = 2, lty = 2)

# Perform Welch's ANOVA (Homoscedasticity Assumption is violated)
oneway.test(length ~ type, data = candles)

# Perform Tukey’s HSD procedure to identify which group means differ from each other
TukeyHSD(candle.aov, conf.level = 0.90)






