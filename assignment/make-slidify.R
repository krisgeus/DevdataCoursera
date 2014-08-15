library(devtools)
install_github("slidify", "ramnathv")
install_github("slidifyLibraries", "ramnathv")
library(slidify)
library(knitr)
setwd("/Users//kgeusebroek/dev/xebia//coursera/devdataprod-004/assignments/DevdataCoursera/assignment-week2/assignment-docs/")
author("assignment-docs")

#edit the index.Rmd
slidify("index.Rmd")
browseURL("index.html")
