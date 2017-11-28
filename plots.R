
## NOTES
# This code was used to plot some charts about the L5R card game
# Starting code taken from http://www.cookbook-r.com/Graphs/Plotting_means_and_error_bars_(ggplot2)/
# This file prepared by @barrytsheppard 

## PREPARATION 

# Clear the data at the start for a tidy environment
rm(list=ls())

# As we want to save files we're setting the directory to the same as the plot.R file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Load Libraries
#install.packages("tidyverse")
library(tidyverse)
#install.packages("ggthemes")
library(ggthemes)


## LOADING DATA

playstyle1 <- data.frame(
  type <- factor(c("Military","Political","Military","Political","Military","Political","Military","Political","Military","Political","Military","Political","Military","Political","Military","Political")),
  turn <- factor(c("Turn 1","Turn 1","Turn 2","Turn 2","Turn 3","Turn 3","Turn 4","Turn 4","Turn 5","Turn 5","Turn 6","Turn 6","Turn 7","Turn 7","Turn 8","Turn 8"), levels=c("Turn 1","Turn 2","Turn 3","Turn 4","Turn 5","Turn 6","Turn 7","Turn 8")),
  force <- c(7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7),
  fate <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
)

## PLOTTING AND SAVING

# Bars
ggplot(data=playstyle1, aes(x=turn, y=force, fill=type)) + 
  geom_bar(colour="black", stat="identity",
           position=position_dodge(),
           size=.3) +                        # Thinner lines
  scale_fill_hue(name="Type") +      # Set legend title
  xlab("Game Turn") + ylab("Total Skill") + # Set axis labels
  ggtitle("Playstyle 1 - Rush, no fate") +     # Set title
  expand_limits(y=c(0,25)) +
  theme_bw() 
ggsave("playstyle1.png")


## LOADING DATA

playstyle2 <- data.frame(
  type <- factor(c("Military","Political","Military","Political","Military","Political","Military","Political","Military","Political","Military","Political","Military","Political","Military","Political")),
  turn <- factor(c("Turn 1","Turn 1","Turn 2","Turn 2","Turn 3","Turn 3","Turn 4","Turn 4","Turn 5","Turn 5","Turn 6","Turn 6","Turn 7","Turn 7","Turn 8","Turn 8"), levels=c("Turn 1","Turn 2","Turn 3","Turn 4","Turn 5","Turn 6","Turn 7","Turn 8")),
  force <- c(4, 4, 8, 8, 12, 12, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16),
  fate <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
)

## PLOTTING AND SAVING

ggplot(data=playstyle2, aes(x=turn, y=force, fill=type)) + 
  geom_bar(colour="black", stat="identity",
           position=position_dodge(),
           size=.3) +                        # Thinner lines
  scale_fill_hue(name="Type") +      # Set legend title
  xlab("Game Turn") + ylab("Total Skill") + # Set axis labels
  ggtitle("Playstyle 2 - One recruit per turn, add 3 fate") +     # Set title
  expand_limits(y=c(0,25)) +
  theme_bw() 
ggsave("playstyle2.png")
## LOADING DATA

playstyle3 <- data.frame(
  type <- factor(c("Military","Political","Military","Political","Military","Political","Military","Political","Military","Political","Military","Political","Military","Political","Military","Political")),
  turn <- factor(c("Turn 1","Turn 1","Turn 2","Turn 2","Turn 3","Turn 3","Turn 4","Turn 4","Turn 5","Turn 5","Turn 6","Turn 6","Turn 7","Turn 7","Turn 8","Turn 8"), levels=c("Turn 1","Turn 2","Turn 3","Turn 4","Turn 5","Turn 6","Turn 7","Turn 8")),
  force <- c(3, 3, 7, 7, 12, 12, 18, 18, 25, 25, 7, 7, 7, 7, 7, 7),
  fate <- c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
)

## PLOTTING AND SAVING

# Bars

ggplot(data=playstyle3, aes(x=turn, y=force, fill=type)) + 
  geom_bar(colour="black", stat="identity",
           position=position_dodge(),
           size=.3) +                        # Thinner lines
  scale_fill_hue(name="Type") +      # Set legend title
  xlab("Game Turn") + ylab("Total Skill") + # Set axis labels
  ggtitle("Playstyle 3 - One recruit per turn, aim for turn 5") +     # Set title
  expand_limits(y=c(0,25)) +
  theme_bw() 
ggsave("playstyle3.png")
