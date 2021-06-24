library(dplyr)
library(tidyverse)
champs <- read.csv("champs.csv")
nba_champs <- champs %>% filter(Lg == 'NBA')
write.csv(nba_champs, "filtered_nba_champs.csv", row.names = FALSE)

wout_champ <- read.csv('nba_champs_train.csv')
team_totals <- read.csv("Team Totals.csv")
for(i in 1:75){
  if(i==1){
    wout_champ$champs <- 0
  }
  else{
    if(wout_champ$season == 2022 - i){
      
    }
  }
}

team_nba  <- wout_champ %>% filter(lg == 'NBA')

for(i in 1:1134){
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

team_nba  <- team_totals %>% filter(season>=1980)
write.csv(wout_champ, "nba_champs_comb1.csv", row.names = FALSE)
sum(team_nba$champs)


team_sum <- read.csv("Team Summaries.csv")
temp <- left_join(team_nba, team_sum, by=c("season", "team"))

temp$wpct <- temp$w/(temp$w+temp$l)
write.csv(temp, "nba_champs_comb2.csv", row.names = FALSE)

avg_removed <- temp[temp$team!= "League Average",]
write.csv(avg_removed, "nba_champs_comb3.csv", row.names = FALSE)
