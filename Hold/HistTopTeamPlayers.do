
use HistFPL17Fixtures,clear

use HistFPL16,clear
gen PlayerName = firstname + " " + surname 


gen PredictOLS = 0
glo xconditions PredictOLS!= 1&GameWeek==37

*Goalies (2)
sum totalpoints if positionslist=="GLK"&GameWeek==2
replace PredictOLS = 1 if totalpoints==r(max)&$xconditions
sum totalpoints if positionslist=="GLK"&$xconditions
replace PredictOLS = 1 if totalpoints==r(max)&$xconditions

*Defenders (5)
forvalues i = 1/5 {
	sum totalpoints if positionslist=="DEF"&$xconditions
	replace PredictOLS = 1 if totalpoints==r(max)&$xconditions
	}
		
*Midfielders (5)
forvalues i = 1/5 {
	sum totalpoints if positionslist=="MID"&$xconditions
	replace PredictOLS = 1 if totalpoints==r(max)&$xconditions
	}

*Strikers (3)
forvalues i = 1/3 {
	sum totalpoints if positionslist=="FWD"&$xconditions
	replace PredictOLS = 1 if totalpoints==r(max)&$xconditions
	}
	
tab PlayerName if PredictOLS==1
tabstat totalpoints if PredictOLS==1,by(PlayerName) s(mean)



*Top players by TEAM
levelsof team,loc(teamlist) 
foreach var of local teamlist {
	gen `=subinstr("`var'"," ","",.)' = 0
	glo xconditions `=subinstr("`var'"," ","",.)' != 1

	*Goalies (2)
	sum averagepoints if positionslist=="GLK"&team=="`var'"
	replace `=subinstr("`var'"," ","",.)'  = 1 if averagepoints==r(max)&$xconditions
	sum averagepoints if positionslist=="GLK"&$xconditions
	replace `=subinstr("`var'"," ","",.)'  = 1 if averagepoints==r(max)&$xconditions

	*Defenders (5)
	forvalues i = 1/5 {
		sum averagepoints if positionslist=="DEF"&$xconditions
		replace `=subinstr("`var'"," ","",.)'  = 1 if averagepoints==r(max)&$xconditions
		}
		
	*Midfielders (5)
	forvalues i = 1/5 {
		sum averagepoints if positionslist=="MID"&$xconditions
		replace `=subinstr("`var'"," ","",.)'  = 1 if averagepoints==r(max)&$xconditions
		}

	*Strikers (3)
	forvalues i = 1/3 {
		sum averagepoints if positionslist=="FWD"&$xconditions
		replace `=subinstr("`var'"," ","",.)'  = 1 if averagepoints==r(max)&$xconditions
		}
	}
	
gen TopTeams = ""	
levelsof team,loc(teamlist) 
foreach var of local teamlist {	
	replace TopTeams = "`var'" if `var' ==1
	}

table PlayerName TopTeams if TopTeams!="",c(mean ictindex)

tabstat 
