
################################################################################
# input values for plot ########################################################
################################################################################

Year <- rep(
  seq(
    min(author$Year),
    max(author$Year),
    length.out = 100
  )
)

critval <- 1.96

# predicted1
newdata1 <- data.frame(
  First.Author = "0",
  Senior.Author = "0",
  Impact.Factor = median(author$Impact.Factor),
  Year = Year,
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
      Year)
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
      Year)
  )

lwr1 <-
  as.data.frame(
    cbind(
      lwr_response1, 
      Year)
  )

# predicted2
newdata2 <- data.frame(
  First.Author = "1",
  Senior.Author = "0",
  Impact.Factor = median(author$Impact.Factor),
  Year = Year,
  Country.of.Origin = "US",
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
      Year)
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
      Year)
  )

lwr2 <-
  as.data.frame(
    cbind(
      lwr_response2, 
      Year)
  )

# predicted3
newdata3 <- data.frame(
  First.Author = "1",
  Senior.Author = "1",
  Impact.Factor = median(author$Impact.Factor),
  Year = Year,
  Country.of.Origin = "US",
  subtopic = "onc"
)

preds3 <- 
  predict(
    mod, 
    newdata = newdata3, 
    type = "link", 
    se.fit = TRUE
  )

fit_link3 <-
  preds3$fit

fit_response3 <-
  mod$family$linkinv(fit_link3)

fit3 <-
  as.data.frame(
    cbind(
      fit_response3, 
      Year)
  )

# ci3
upr_link3 <-
  preds3$fit + (critval * preds3$se.fit)

lwr_link3 <- 
  preds3$fit - (critval * preds3$se.fit)

upr_response3 <- 
  mod$family$linkinv(upr_link3)

lwr_response3 <- 
  mod$family$linkinv(lwr_link3)

upr3 <-
  as.data.frame(
    cbind(
      upr_response3, 
      Year)
  )

lwr3 <-
  as.data.frame(
    cbind(
      lwr_response3, 
      Year)
  )

# predicted4
newdata4 <- data.frame(
  First.Author = "0",
  Senior.Author = "1",
  Impact.Factor = median(author$Impact.Factor),
  Year = Year,
  Country.of.Origin = "US",
  subtopic = "onc"
)

preds4 <- 
  predict(
    mod, 
    newdata = newdata4, 
    type = "link", 
    se.fit = TRUE
  )

fit_link4 <-
  preds4$fit

fit_response4 <-
  mod$family$linkinv(fit_link4)

fit4 <-
  as.data.frame(
    cbind(
      fit_response4, 
      Year)
  )

# ci4
upr_link4 <-
  preds4$fit + (critval * preds4$se.fit)

lwr_link4 <- 
  preds4$fit - (critval * preds4$se.fit)

upr_response4 <- 
  mod$family$linkinv(upr_link4)

lwr_response4 <- 
  mod$family$linkinv(lwr_link4)

upr4 <-
  as.data.frame(
    cbind(
      upr_response4, 
      Year)
  )

lwr4 <-
  as.data.frame(
    cbind(
      lwr_response4, 
      Year)
  )

################################################################################
# plot #########################################################################
################################################################################

author <- author %>%
    
  mutate(
    test = ifelse(
      First.Author == 0 & Senior.Author == 0,
      "M-M",
      ifelse(
        First.Author == 1 & Senior.Author == 0,
        "F-M",
        ifelse(
          First.Author == 1 & Senior.Author == 1,
          "F-F",
          ifelse(
            First.Author == 0 & Senior.Author == 1,
            "M-F",
            "NA"
          )
        )
      )
    )
  )

author$test <- factor(
  author$test, 
  levels = c("M-M", 
             "F-M", 
             "F-F", 
             "M-F")
  )

author %>%
  
  ggplot(
    aes(
      x = Year, 
      y = Funding,
      color = as.factor(test)
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
      2012, 
      2023
    ),
    breaks = c(2013, 2016, 2019, 2022)
  ) +
  
  geom_line(
    fit1, 
    mapping = aes(
      x = Year, 
      y = fit_response1
    ),
    color = "#FF5733",
  ) +
  
  geom_line(
    fit2, 
    mapping = aes(
      x = Year, 
      y = fit_response2
    ),
    color = "#1ABC9C",
  ) +

  geom_line(
    fit3, 
    mapping = aes(
      x = Year, 
      y = fit_response3
    ),
    color = "#C77CFF",
  ) +
  
  geom_line(
    fit4, 
    mapping = aes(
      x = Year, 
      y = fit_response4
    ),
    color = "darkgray",
  ) +
  
  ggtitle("") +
  
  xlab("Year") +
  
  ylab("Probability of Funding") +
  
  theme_bw() +
  
  theme(
    legend.position = "right",
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  ) +
  
  # legend and override alpha
  scale_color_manual(
    
    values = c("M-M" = "#FF5733", 
               "F-M" = "#1ABC9C",
               "F-F" = "#C77CFF",
               "M-F" = "darkgray"),
    
    labels = c("M-M", 
               "F-M",
               "F-F",
               "M-F"),
    
    name = ""
    
  ) +
  
  guides(
    color = guide_legend(
      override.aes = list(alpha = 1)
    )
  )

ggsave("out/plot_funding.png", height = 6, width = 8)
