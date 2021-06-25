# Nome: Understanding correlations
# Autor: Gabriel dos Reis Rodrigues
# June, 2021
# Last update: 2021-06-25
# ----------------------------------------

# Initial loading ====
if(!require("faux"))
  install.packages("faux"); library(faux)
if(!require("ggplot2"))
  install.packages("ggplot2"); library(ggplot2)
if(!require("plotly"))
  install.packages("plotly"); library(plotly)

dat <- rnorm_multi(n = 1000, 
                   mu = c(20, 20),
                   sd = c(5, 5),
                   r = c(0.5), 
                   varnames = c("A", "B"),
                   empirical = T)
dat

psych::describe(dat)
?rnorm_multi

ggplot(dat, aes(x = A, y = B)) +
  
  # Pontos
  geom_point(alpha = 0.5, position = 'jitter', color = "#011e5a") +
  
  # Linha
  stat_smooth(method = "lm", se = F, color = "#011F5a", size = 1.5) +
  
  # Ajustando x
  xlab('X') +
  
  # Ajustando y
  ylab('Y') +
  
  # theme
  theme_classic()
