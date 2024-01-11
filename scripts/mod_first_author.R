library(tidyverse)

# fit --------------------------------------------------------------------------
mod <- glm(
  First.Author ~
    as.factor(Senior.Author) +
    scale(Impact.Factor) +
    as.factor(Senior.Author) * scale(as.numeric(Year), scale = FALSE) +
    scale(as.numeric(Year), scale = FALSE) +
    Country.of.Origin +
    subtopic,
  family = "binomial",
  data = author
)

# summary
summary(mod)

# multicollinearity
car::vif(mod)

# plot
source("scripts/plots/plot_first_author_senior.R")
plot(last_plot())
