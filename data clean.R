library(dplyr)
library(tidyverse)
champs <- read.csv("champs.csv")
nba_champs <- champs %>% filter(Lg == 'NBA')
write.csv(nba_champs, "filtered_nba_champs.csv", row.names = FALSE)

team_totals <- read.csv("Team Totals.csv")

# Filter out season before 1980
team_nba  <- team_totals %>% filter(season>=1980)
# Filter out stats that are too old and not in NBA
team_nba  <- team_nba %>% filter(lg == 'NBA')

# Join additional data from another csv provided
team_sum <- read.csv("Team Summaries.csv")
temp <- left_join(team_nba, team_sum, by=c("season", "team"))
temp$wpct <- temp$w/(temp$w+temp$l)

# Remove the rows League Vaerage
avg_removed <- temp[temp$team!= "League Average",]

# Now we want to split the data into current season and previous seasons

# Filter out the stats that is running in the current season
wout_champ <- avg_removed %>% filter(season!=2021)
# Filter out the stats that is for the current season
sea21 <- avg_removed %>% filter(season==2021)

# Add whether a team is a champion for past seasons
for(i in 1:dim(wout_champ)[1]){
  indx = 2021 - wout_champ$season[i]
  if(indx >0){
    if(nba_champs$Champion[indx] ==wout_champ$team[i]){
      wout_champ$champs[i] = 1
    }
    else{
      wout_champ$champs[i] = 0
    }
  }
}

write.csv(wout_champ, "nba_champs_comb1.csv", row.names = FALSE)
write.csv(sea21, "sea21.csv", row.names = FALSE)
