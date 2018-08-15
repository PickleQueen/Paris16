
cd "$WorkingDirectory"

import excel using FPL_api,describe
import excel using FPL_api,sheet(FPL_api) clear first

gen teamvar_name = ""
gen WorstPicks = 0

do RenVar.do
do Destring.do

gen PlayerName = first_name + " " + second_name

*merge 1:1 PlayerName teamvar_name using PlayerChar

**PLAYER INJURED & SUSPENDED
gen ReturnBack = regexm(news,"Suspended until")
replace ReturnBack = regexm(news,"Expected back")

drop if news!=""&ReturnBack!=1
drop if id ==273 ///de Bruyne
drop if id ==357 ///Trippier

gen GWScores1 = 0.0768 *selected_by_percent+5.162 *value_form-0.0709
gen GWScores2 = 0.155 *selected_by_percent+6.982 *value_form + 0.769
gen GWScores3 = 0.234 *selected_by_percent+8.678 *value_form + 1.666
gen GWScores4 = 0.347 *selected_by_percent+9.781 *value_form + 2.629
gen GWScores5 = 0.483 *selected_by_percent+11.02 *value_form + 3.511
gen GWScores6 = 0.612 *selected_by_percent+11.91 *value_form + 4.438
gen GWScores7 = 0.699 *selected_by_percent+12.82 *value_form + 5.573
gen GWScores8 = 0.769 *selected_by_percent+13.38 *value_form + 6.67
gen GWScores9 = 0.869 *selected_by_percent+14.17 *value_form + 7.65
gen GWScores10 = 0.953 *selected_by_percent+14.93 *value_form + 8.746
gen GWScores11 = 1.045 *selected_by_percent+15.75 *value_form + 9.721
gen GWScores12 = 1.176 *selected_by_percent+15.9 *value_form + 10.89
gen GWScores13 = 1.26 *selected_by_percent+16.4 *value_form + 11.96
gen GWScores14 = 1.385 *selected_by_percent+16.67 *value_form + 13.15
gen GWScores15 = 1.441 *selected_by_percent+17.59 *value_form + 14.21
gen GWScores16 = 1.477 *selected_by_percent+18.96 *value_form + 15.16
gen GWScores17 = 1.548 *selected_by_percent+19.66 *value_form + 16.41
gen GWScores18 = 1.649 *selected_by_percent+19.82 *value_form + 17.71
gen GWScores19 = 1.765 *selected_by_percent+20.69 *value_form + 18.68
gen GWScores20 = 1.913 *selected_by_percent+20.75 *value_form + 19.83
gen GWScores21 = 1.96 *selected_by_percent+21.61 *value_form + 20.89
gen GWScores22 = 2.026 *selected_by_percent+21.98 *value_form + 22.18
gen GWScores23 = 2.133 *selected_by_percent+22.62 *value_form + 23.23
gen GWScores24 = 2.165 *selected_by_percent+23.74 *value_form + 24.28
gen GWScores25 = 2.254 *selected_by_percent+24.44 *value_form + 25.14
gen GWScores26 = 2.29 *selected_by_percent+25.7 *value_form + 25.99
gen GWScores27 = 2.368 *selected_by_percent+26.71 *value_form + 26.93
gen GWScores28 = 2.476 *selected_by_percent+27.6 *value_form + 27.69
gen GWScores29 = 2.566 *selected_by_percent+28.13 *value_form + 28.66
gen GWScores30 = 2.646 *selected_by_percent+29.08 *value_form + 29.61
gen GWScores31 = 2.709 *selected_by_percent+29.36 *value_form + 29.96
gen GWScores32 = 2.824 *selected_by_percent+29.37 *value_form + 31.06
gen GWScores33 = 2.878 *selected_by_percent+30.22 *value_form + 31.96
gen GWScores34 = 3 *selected_by_percent+31.22 *value_form + 33.22
gen GWScores35 = 3.04 *selected_by_percent+31.73 *value_form + 33.87
gen GWScores36 = 3.118 *selected_by_percent+32.56 *value_form + 34.98
gen GWScores37 = 3.231 *selected_by_percent+34.59*value_form + 37.9

reshape long GWScores,i(id)
ren _j gameweek
bysort id: egen AvgGWScores =mean(GWScores)
tabstat GWScores,by(PlayerName) s(mean)

tabstat AvgGWScores,by(PlayerName) s(mean)
tabstat GWScores if gameweek==36,by(PlayerName) s(mean)

gen PredictList = 0
glo xconditions PredictList!= 1&!inlist(id,267,282,378)

*Goalies (2)
sum AvgGWScores if element_type==1
replace PredictList = 1 if AvgGWScores==r(max)&$xconditions
sum AvgGWScores if element_type==1&$xconditions
replace PredictList = 1 if AvgGWScores==r(max)&$xconditions

*Defenders (5)
forvalues i = 1/5 {
	sum AvgGWScores if element_type==2&$xconditions
	replace PredictList = 1 if AvgGWScores==r(max)&$xconditions
	}
*Midfielders (5)
forvalues i = 1/5 {
	sum AvgGWScores if element_type==3&$xconditions
	replace PredictList = 1 if AvgGWScores==r(max)&$xconditions
	}

*Strikers (3)
forvalues i = 1/3 {
	sum AvgGWScores if element_type==4&$xconditions
	replace PredictList = 1 if AvgGWScores==r(max)&$xconditions
	}

tab PlayerName if PredictList == 1
tabstat id if PredictList==1,by(web_name) s(mean)
tabstat now_cost if PredictList == 1, by(PlayerName) s(mean)
tabstat GWScores if gameweek == 2, by(PlayerName) s(mean)

tsset id gameweek
bysort id: gen scorechange = GWScores-l.GWScores

*do PlayerTrends.do

*do PositionPointShares.do
	
collapse (mean) GWScores,by(PlayerName gameweek id element_type team)
reshape wide GWScores ,i(id PlayerName ) j(gameweek )

capture drop GW*ScoresUp
forvalues i = 1/36 {
	gen GW`i'ScoresUp = GWScores`=1+`i''-GWScores`i' 
	}
	

gen PredictList = 0
glo xconditions PredictList!= 1

*Goalies (2)
sum GW2ScoresUp if element_type==1
replace PredictList = 1 if GW2ScoresUp==r(max)&$xconditions
sum GW2ScoresUp if element_type==1&$xconditions
replace PredictList = 1 if GW2ScoresUp==r(max)&$xconditions

*Defenders (5)
forvalues i = 1/5 {
	sum GW2ScoresUp if element_type==2&$xconditions
	replace PredictList = 1 if GW2ScoresUp==r(max)&$xconditions
	}
*Midfielders (5)
forvalues i = 1/5 {
	sum GW2ScoresUp if element_type==3&$xconditions
	replace PredictList = 1 if GW2ScoresUp==r(max)&$xconditions
	}

*Strikers (3)
forvalues i = 1/3 {
	sum GW2ScoresUp if element_type==4&$xconditions
	replace PredictList = 1 if GW2ScoresUp==r(max)&$xconditions
	}

tab PlayerName if PredictList == 1
tabstat id if PredictList==1,by(PlayerName) s(mean)
tabstat GW2ScoresUp, by(PlayerName) s(mean) sort
