library(growthbreaks)
library(dplyr)
codspec <- read.csv(here::here('work','assessments','ai-pcod','survey_specimen_data_pcod.csv'))
names(codspec) <- tolower(names(codspec))

codspec <- codspec %>% 
  filter(sex != 3) %>%
  dplyr::select(sex, year, age, length, lat = end_latitude , long = end_longitude) %>%
  group_split(sex) 

## Males (Sex == 1)
dat_use <- data.frame(codspec[[1]])
check_data(dat_use)

breakpoints <- get_Breaks(dat = dat_use,
                          ages_to_use = c(3,5,7,9),
                          sex = FALSE, 
                          axes = 0, 
                          showPlot = TRUE)
## the longitude break is meaningless, delete a priori
breakpoints$long<- -Inf
fits1 <- refit_Growth( dat_use, breakpoints, showPlot = TRUE)

## Females 
dat_use <- data.frame(codspec[[2]])
check_data(dat_use)

breakpoints <- get_Breaks(dat = dat_use,
                          ages_to_use = c(3,5,7,9),
                          sex = FALSE, 
                          axes = 0, 
                          showPlot = TRUE)
 
## the first and second lat breaks can probably be combined
## and the first long break is meaningless
breakpoints$lat[2] <- 53
breakpoints <- breakpoints[2:3,]
breakpoints <- breakpoints[2,]
fits1 <- refit_Growth( dat_use, breakpoints, showPlot = TRUE)
