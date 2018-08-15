* xi: areg totalpoints selectedbypercent valueform i.teamid if GameWeek==2,r a(GameWeek)
* _b[selectedbypercent ] = .1415292
* _b[valueform] = 9.846862

areg total_points selected_by_percent value_form,r a(team_code)

gen GW2Scores = 0.1415292*selected_by_percent + 9.846862*value_form
tabstat GW2Scores,by(PlayerName) s(mean)

gen GWList=0
glo xconditions GWList!= 1

*Goalies (2)
sum GW2Scores if element_type ==1
replace GWList = 1 if GW2Scores==r(max)&$xconditions
sum GW2Scores if element_type ==1&$xconditions
replace GWList = 1 if GW2Scores==r(max)&$xconditions

*Defenders (5)
forvalues i = 1/5 {
	sum GW2Scores if element_type ==2&$xconditions
	replace GWList = 1 if GW2Scores==r(max)&$xconditions
	}
*Midfielders (5)
forvalues i = 1/5 {
	sum GW2Scores if element_type ==3&$xconditions
	replace GWList = 1 if GW2Scores==r(max)&$xconditions
	}

*Strikers (3)
forvalues i = 1/3 {
	sum GW2Scores if element_type ==4&$xconditions
	replace GWList = 1 if GW2Scores==r(max)&$xconditions
	}
tab PlayerName if GWList==1
tabstat now_cost if GWList==1,by(PlayerName) s(mean N)
