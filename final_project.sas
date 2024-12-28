* importing our candle.type.csv file;
proc import datafile= '/home/u63558088/Data_set/Candles.csv'
dbms=csv
out=candle
replace;

* ploting a box plot of candle length for each candle types ;
proc sgplot data=candle;
vbox length / group=type;
title 'Parallel box plot of Candle length for each Candle types';

* creating summary table for the all candle length;
proc means data=candle
n mean median std;
var length;

*creating summary table for the candle length of each candle type;
proc means data= candle
n mean median std;
var length;
class type;

* one-way ANOVA;
proc anova data=candle;
class type;
model length=type;
mean alpha=0.1;

*Let's perform one-way ANOVA for our experiment
*Assumptions for one way anova
 random samples are collected from their respective populations
 the samples are collected independently of one another
 the response variables all come from a normal distribution
 the population variances are all equal;
 

* let's check for normality from the normal qqplot of residuals;
* should use proc glm for getting the plots of diagnostics;
proc glm data=candle plots=diagnostics;
class type;
model length=type;

* let's check for homoscedasticity;
* should use proc glm for getting the plots of diagnostics;
proc glm data=candle plots=diagnostics;
class type;
model length=type;
* Since the assumption of homoscedasticity is violated we must use Welch's anova test;

* Welch's anova analysis;
proc anova data=candle;
class type;
model length=type;
means type/ welch;

*post-hoc comparison using tukey;
proc anova data=candle;
class type;
model length=type ;
means type/tukey lines cldiff alpha=0.1;






