library(tidyverse)
library(ggthemes)
library(zoo)
library(gganimate)

# saveRDS(data, file = "acled1720.RDS")

readRDS("acled1720.RDS")

regions <- c("South America", "South Asia", "Europe", "Middle East", "Central America", "Caucasus and Central Asia")

p <- data %>%
  mutate(obs = 1,
         region = as.factor(region)) %>%
  filter(date <= "2020-12-31") %>%
  group_by(region, yrmonth) %>%
  summarise(sum_events = sum(obs),
            mean_events = mean(sum_events)) %>%
  filter(region %in% regions) %>%
  ggplot(aes(yrmonth, sum_events, group = region, shape = region, color = region)) +
  geom_line() +
  geom_point() +
  geom_vline(aes(xintercept = as.integer(as.Date("2020-02-01"))),
             linetype="longdash", colour = "black", size=.2) +
  scale_color_manual(values = c("#335c67", "#fff3b0", "#e09f3e", "#9e2a2b", "#540b0e", "black")) +
  scale_shape_manual(values=1:nlevels(data$region)) +
  labs(shape = "", 
       color = "") +
  xlab("Date") +
  ylab("# Events") +
  ggtitle("All events") + 
  # facet_wrap(~region) +
  theme_tufte(base_family = "Helvetica") +
  theme(legend.position = "bottom", 
        legend.direction = "horizontal",) +
  guides(shape = guide_legend(nrow = 2)) +
  # Here comes the gganimate specific bits
  transition_reveal(yrmonth)

animate(p, fps=10)

anim_save("all_events.gif", animation = last_animation())

p1 <- data %>%
  mutate(obs = 1,
         region = as.factor(region)) %>%
  filter(date <= "2020-12-31",
         event_type== "Protests") %>%
  group_by(region, yrmonth) %>%
  summarise(sum_events = sum(obs),
            mean_events = mean(sum_events)) %>%
  filter(region %in% regions) %>%
  ggplot(aes(yrmonth, sum_events, group = region, shape = region, color = region)) +
  geom_line() +
  geom_point() +
  ggtitle("Protests") + 
  geom_vline(aes(xintercept = as.integer(as.Date("2020-02-01"))),
             linetype="longdash", colour = "black", size=.2) +
  scale_color_manual(values = c("#335c67", "#fff3b0", "#e09f3e", "#9e2a2b", "#540b0e", "black")) +
  scale_shape_manual(values=1:nlevels(data$region)) +
  labs(shape = "", 
       color = "") +
  xlab("Date") +
  ylab("# Events") +
  # facet_wrap(~region) +
  theme_tufte(base_family = "Helvetica") +
  theme(legend.position = "bottom", 
        legend.direction = "horizontal",) +
  guides(shape = guide_legend(nrow = 2)) +
  # Here comes the gganimate specific bits
  transition_reveal(yrmonth)

animate(p1, fps=10)

anim_save("protests.gif", animation = last_animation())