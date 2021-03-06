---
title       : "Assignment week 2 documentation"
subtitle    : "Shiny app for developing data products course"
author      : "Kris Geusebroek"
job         : "Big Data Hacker"
framework   : html5slides   # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]     # {mathjax, quiz, bootstrap}
knit        : slidify::knit2slides
mode        : selfcontained # {standalone, draft}
---

## Assignment documentation

The assignment was:

``This peer assessed assignment has two parts. First, you will create a Shiny application and deploy it on Rstudio's servers. Second, you will use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about your application.``

This is the documentation part.  

The application is at: [http://krisgeus.shinyapps.io/assignment/](http://krisgeus.shinyapps.io/assignment/). 

---

## The application
The goal of the application is to find the maximum value in some distribution. 
Determining the maximum is done by taking a sample and in every next iteration take the top 20% like this:

```r
#prepare data
x = c(1,2,3,4,5,6,7,8,9,10)
y = c(5,6,7,8,5,6,7,8,5,4)
df = data.frame(x=x, y=y)

#select top20%
bestof = df[ order(-df$y), ][1:round(nrow(df)/5),]
bestof
```

```
##   x y
## 4 4 8
## 8 8 8
```
and for each of these values sample 5 new points within a range from that point.

---

## Used technologies
I used the following technologies / tools:

1. RStudio for developing
2. ggplot for plots
3. shiny for the application
4. slidify for the documentation
5. shinyapps for publishing the application
6. github pages for publishing the docs
7. github for publishing the code

---

## The code

```r
newsample = function(bestxvals, num, xrange, gmin, gmax){
  xvals = rep(bestxvals,num) + runif(length(bestxvals)*num,-xrange,xrange)
  xvals = sapply(xvals, function(x){ return(max(min(x, gmax), gmin)) } ) 
  yvals = sapply(xvals, function(x) {sin(x*10)/10 + 2^(-(x)^2)})
  newdf = data.frame(x = xvals, y = yvals)
  return(newdf)
}

sample_size = 20; numiters = 5 #in app provided by UI

xvals = seq(-4, 4, 0.02)
yvals = sapply(xvals, function(x) {sin(x*10)/10 + 2^(-(x)^2)})
distdf = data.frame( x=xvals, y= yvals)

samplesx = runif(sample_size, -4, 4)
samplesy = sapply(samplesx, function(x) {sin(x*10)/10 + 2^(-(x)^2)})
sampledf = data.frame( x=samplesx, y=samplesy)

for( i in 1:numiters ){
  bestof   = sampledf[ order(-sampledf$y), ][1:round(nrow(sampledf)/5),]
  sampledf = newsample(bestof$x, 5, (4 - -4)/(numiters+1), -4, 4 )
}
```

---

## User interface 
The application has 2 different type of elements:

1. The sliders
    - Slider to get user input about the sample size
    - Slider to get user input about the number of iterations for the algorithm

2. The output plots for different functions
    - Distribution from the function: $sin(10x)/10 + 2^{-x^2}$
    - Distribution from the function: $sin(10x)$
    - Distribution from the function: $5sin(x)/(x^2+1)^2$

Selected samples form the last (and best predicting) iteration are colored red. The final maximum is colored green.
