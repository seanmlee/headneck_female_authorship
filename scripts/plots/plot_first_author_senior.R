
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
  Senior.Author = "1",
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

################################################################################
# plot #########################################################################
################################################################################

author %>%
  
  ggplot(
    aes(
      x = Year, 
      y = First.Author,
      color = as.factor(Senior.Author)
    )
  ) +
  
  geom_point(
    alpha = 0,
    size = 5
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
    linewidth = 1.5,
    color = "#FF5733",
  ) +
  
  geom_ribbon(
    data = newdata1,
    mapping = 
      aes(
        x = Year,
        y = fit_response1,
        ymin = lwr_response1,
        ymax = upr_response1
      ),
    alpha = 0.25,
    fill = "#FF5733",
    color = NA
  ) +
  
  geom_line(
    fit2, 
    mapping = aes(
      x = Year, 
      y = fit_response2
    ),
    linewidth = 1.5,
    color = "#1ABC9C",
  ) +
  
  geom_ribbon(
    data = newdata2,
    mapping = 
      aes(
        x = Year,
        y = fit_response2,
        ymin = lwr_response2,
        ymax = upr_response2
      ),
    alpha = 0.25,
    fill = "#00BFC4",
    color = NA
  ) +
  
  ggtitle("") +
  
  xlab("Year") +
  
  ylab("Probability of Female First Authorship") +
  
  theme_bw() +
  
  theme(
    legend.position = "right",
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x = element_text(size = 20),
    axis.text.y = element_text(size = 20),
    axis.title.x = element_text(size = 25, margin = margin(t = 15)),
    axis.title.y = element_text(size = 25, margin = margin(r = 15)),
    legend.text = element_text(size = 20),
    legend.title = element_text(size = 25)
  ) +
  
  # legend and override alpha
  scale_color_manual(
    
    values = c("0" = "#FF5733", 
               "1" = "#1ABC9C"),
    
    labels = c("Male", 
               "Female"),
    
    name = "Senior Author"
    
  ) +
  
  guides(
    color = guide_legend(
      override.aes = list(alpha = 1)
    )
  )

ggsave("out/plot_first_author_senior.png", height = 7, width = 10)
