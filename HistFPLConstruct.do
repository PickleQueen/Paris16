cd "$WorkingDirectory"
*Create historical data using FPL Season 15-16
insheet using FPL16-GW5.csv,clear
drop gw*forecast nextfixture*

gen GameWeek = 5
save HistFPL16,replace

forvalues i = 6/37 {
	insheet using FPL16-GW`i'.csv,clear
	drop gw*forecast nextfixture*
	gen GameWeek = `i'
	gen Season = 16
	append using HistFPL16
	save HistFPL16,replace
	}

*Create historical data using FPL Season 16-17
insheet using FPL17-GW0.csv,clear
drop gw*forecast nextfixture*
gen GameWeek = 0
save HistFPL17,replace

forvalues i = 1/37 {
	insheet using FPL17-GW`i'.csv,clear
	drop gw*forecast nextfixture*
	gen GameWeek = `i'
	gen Season = 17
	append using HistFPL17
	save HistFPL17,replace
	}
	
append using HistFPL16
compress
replace eaindex =. if Season==17

gen match_code = .
replace match_code =1 if team =="ARS"
replace match_code =2 if team =="BHA"
replace match_code =3 if team =="BOU"
replace match_code =4 if team =="BUR"
replace match_code =5 if team =="CHE"
replace match_code =6 if team =="CRY"
replace match_code =7 if team =="EVE"
replace match_code =8 if team =="HUD"
replace match_code =9 if team =="HUL"
replace match_code =10 if team =="LEI"
replace match_code =11 if team =="LIV"
replace match_code =12 if team =="MCI"
replace match_code =13 if team =="MID"
replace match_code =14 if team =="MUN"
replace match_code =15 if team =="NEW"
replace match_code =16 if team =="SOU"
replace match_code =17 if team =="STK"
replace match_code =18 if team =="SUN"
replace match_code =19 if team =="SWA"
replace match_code =20 if team =="TOT"
replace match_code =21 if team =="WAT"
replace match_code =22 if team =="WBA"
replace match_code =23 if team =="WHU"

gen PlayerName = firstname + " " + surname 
do PlayerNameCorrection.do

save HistFPL1617,replace	

********************************************************************************

import excel using FPL_api,sheet(Fixtures1718) clear first

do MatchCodes.do

save Fixtures1718,replace

use HistFPL1617,clear
drop if Season==16

ren match_code Home_code

merge m:1 Home_code GameWeek using Fixtures1718, nogen
ren Home AsHome
ren Away OppositionAsHome
drop Away_code

ren Home_code Away_code

merge m:1 Away_code GameWeek using Fixtures1718, nogen
drop Home_code
ren Away AsAway
ren Home OppositionAsAway

ren Away_code match_code

save HistFPL17Fixtures,replace
