library(knitr)
rmdfiles <- c("logistic.rmd")
sapply(rmdfiles, knit, quiet = T)