library(tidyverse)

# fit --------------------------------------------------------------------------
mod <- glm(
  Senior.Author ~
    scale(Impact.Factor) +
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
source("scripts/plots/plot_senior_author_impact.R")
plot(last_plot())
