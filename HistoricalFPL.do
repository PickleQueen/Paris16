
use HistFPL1617,clear
gen seasondummy = (Season==17)

areg totalpoints ictindex if Season==17,r a(GameWeek)
areg totalpoints eaindex if Season==16,r a(GameWeek)
areg bps ictindex if Season==17,r a(GameWeek)
areg bps eaindex if Season==16,r a(GameWeek)


*Team Stats
collapse (mean) AvgIctTeam=ictindex AvgPointsTeam=totalpoints AvgEATeam=eaindex (sum) TotIctTeam=ictindex TotPointsTeam=totalpoints,by(GameWeek Season team)

sepscatter AvgIctTeam GameWeek if Season==17,c(l) sep(team) graphregion(col(white))
sepscatter AvgEATeam GameWeek if Season==16,c(l) sep(team) graphregion(col(white))
sepscatter TotPointsTeam GameWeek if Season==16,c(l) sep(team) graphregion(col(white))


gen PlayerName = firstname + " " + surname
gen ImputeList = 0
do ImputeList.do 

*Top players Season 16/17
gen HistList = 0
glo xconditions Season==17

*Goalies (2)
sum ictindex if positionslist=="GLK"&$xconditions
replace HistList = 1 if ictindex==r(max)
sum ictindex if positionslist=="GLK"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

*Defenders (5)
sum ictindex if positionslist=="DEF"&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="DEF"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="DEF"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="DEF"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="DEF"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

*Midfielders (5)
sum ictindex if positionslist=="MID"&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="MID"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="MID"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="MID"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="MID"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

*Strikers (3)
sum ictindex if positionslist=="FWD"&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="FWD"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)

sum ictindex if positionslist=="FWD"&HistList != 1&$xconditions
replace HistList = 1 if ictindex==r(max)



