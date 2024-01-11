library(tidyverse)

# fit glm() logit --------------------------------------------------------------
mod <- glm(
  Funding ~
    as.factor(First.Author) +
    as.factor(Senior.Author) +
    scale(as.numeric(Year), scale = FALSE) +
    as.factor(First.Author) * as.factor(Senior.Author) * scale(as.numeric(Year), scale = FALSE) +
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
source("scripts/plots/plot_funding.R")
plot(last_plot())
