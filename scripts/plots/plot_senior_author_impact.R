
################################################################################
# input values for plot ########################################################
################################################################################

Impact.Factor <- rep(
  seq(
    min(author$Impact.Factor),
    max(author$Impact.Factor),
    length.out = 100
  )
)

critval <- 1.96

# predicted1
newdata1 <- data.frame(
  Impact.Factor = Impact.Factor,
  Year = median(author$Year),
  Country.of.Origin = "US",
  subtopic = "onc"
)

preds1 <- 
  predict(
    mod, 
    newdata = newdata1, 
    type = "link", 
    se.fit = TRUE
  )

fit_link1 <-
  preds1$fit

fit_response1 <-
  mod$family$linkinv(fit_link1)

fit1 <-
  as.data.frame(
    cbind(
      fit_response1, 
      Impact.Factor)
  )

# ci1
upr_link1 <-
  preds1$fit + (critval * preds1$se.fit)

lwr_link1 <- 
  preds1$fit - (critval * preds1$se.fit)

upr_response1 <- 
  mod$family$linkinv(upr_link1)

lwr_response1 <- 
  mod$family$linkinv(lwr_link1)

upr1 <-
  as.data.frame(
    cbind(
      upr_response1, 
      Impact.Factor)
  )

lwr1 <-
  as.data.frame(
    cbind(
      lwr_response1, 
      Impact.Factor)
  )

# predicted2
newdata2 <- data.frame(
  Impact.Factor = Impact.Factor,
  Year = median(author$Year),
  Country.of.Origin = "Non US",
  subtopic = "onc"
)

preds2 <- 
  predict(
    mod, 
    newdata = newdata2, 
    type = "link", 
    se.fit = TRUE
  )

fit_link2 <-
  preds2$fit

fit_response2 <-
  mod$family$linkinv(fit_link2)

fit2 <-
  as.data.frame(
    cbind(
      fit_response2, 
      Impact.Factor)
  )

# ci2
upr_link2 <-
  preds2$fit + (critval * preds2$se.fit)

lwr_link2 <- 
  preds2$fit - (critval * preds2$se.fit)

upr_response2 <- 
  mod$family$linkinv(upr_link2)

lwr_response2 <- 
  mod$family$linkinv(lwr_link2)

upr2 <-
  as.data.frame(
    cbind(
      upr_response2, 
      Impact.Factor)
  )

lwr2 <-
  as.data.frame(
    cbind(
      lwr_response2, 
      Impact.Factor)
  )

################################################################################
# plot #########################################################################
################################################################################

dat_plot1 <- author

dat_plot1 <- dat_plot1 %>%
  mutate(
    Senior.Author = ifelse(
      Senior.Author == "M", 
      0, 
      1
    )
  )

dat_plot1 %>%
  
  ggplot(
    aes(
      x = Impact.Factor, 
      y = Senior.Author
    )
  ) +
  
  geom_point(
    alpha = 0
  ) +
  
    scale_y_continuous(
      labels = scales::percent,
      limits = c(0, 1)
    ) +
  
  scale_x_continuous(
    limits = c(
      0, 
      45
    )
  ) +
  
  geom_line(
    fit1, 
    mapping = aes(
      x = Impact.Factor, 
      y = fit_response1
    ),
    color = "#FF5733",
  ) +
  
  geom_line(
    data = newdata1, 
    mapping = aes(
      x = Impact.Factor, 
      y = upr_response1
    ),
    color = "#FF5733",
    linewidth = 0.1,
    linetype = "dashed") + 
  
  geom_line(
    data = newdata1, 
    mapping = aes(
      x = Impact.Factor, 
      y = lwr_response1
    ),
    color = "#FF5733",
    linewidth = 0.1,
    linetype = "dashed") +
  
  ggtitle("") +
  
  xlab("Impact Factor") +
  
  ylab("Probability of Female Senior Authorship") +
  
  theme_bw() +
  
  theme(
    legend.position = "right",
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

ggsave("out/plot_senior_author_impact.png", height = 6, width = 8)
