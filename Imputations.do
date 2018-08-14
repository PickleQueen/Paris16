
*PREDICTIONS
use HistFPL1617,clear
gen PlayerName = firstname + " " + surname

drop if Season==16
preserve
forvalues i = 1/37 {
	keep if inlist(GameWeek,`i',`=1+`i'')
	tab team,gen(i_team)
	gen GameWeek2Forecast = totalpoints if GameWeek==`i'

	mdesc GameWeek2Forecast
	mi set mlong
	mi register imputed GameWeek2Forecast

	mi impute regress GameWeek2Forecast ictindex selectedbypercent i_team*, by(positionslist) rseed(53421) add(100)

	gen GameWeek2ForecastRound = round(GameWeek2Forecast)
	gen pointsdiff = totalpoints-GameWeek2ForecastRound

	collpase (mean) GameWeek2ForecastRound totalpoints pointsdiff,by(PlayerName)
	save ImputedS17GameWk`i',replace
	restore
	}


tabstat GameWeek2ForecastRound totalpoints pointsdiff if Season ==17&GameWeek ==2,by(PlayerName) s(mean)
*ed totalpoints pointsdiff i_totalpoints i_totalpointsvar i_totalpointsround


gen ImputeList = 0
glo xconditions Season==17

*Goalies (2)
sum i_totalpoints if positionslist=="GLK"&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)
sum i_totalpoints if positionslist=="GLK"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

*Defenders (5)
sum i_totalpoints if positionslist=="DEF"&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="DEF"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="DEF"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="DEF"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="DEF"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

*Midfielders (5)
sum i_totalpoints if positionslist=="MID"&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="MID"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="MID"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="MID"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="MID"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

*Strikers (3)
sum i_totalpoints if positionslist=="FWD"&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="FWD"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)

sum i_totalpoints if positionslist=="FWD"&ImputeList != 1&$xconditions
replace ImputeList = 1 if i_totalpoints==r(max)


tab PlayerName if ImputeList==1


