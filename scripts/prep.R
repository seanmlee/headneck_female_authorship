
library("tidyverse")

# read (Male = 0; Female = 1; Unfunded = 0; Funded = 1)
author <- read.csv("data/author.csv", header = TRUE)

# format
author$Country.of.Origin <- 
  factor(
    author$Country.of.Origin, 
    levels = c(
      "US", 
      "Non US"
    )
  )

author$subtopic <- 
  factor(
    author$subtopic, 
    levels = c(
      "onc", 
      "endo", 
      "recon", 
      "other"
    )
  )
