cd "$WorkingDirectory"
*Create historical data using FPL Season 16-17
insheet using FPL16-GW5.csv,clear
drop gw*forecast nextfixture*

gen GameWeek = 5
//SAVE
save HistFPL16,replace

forvalues i = 6/37 {
	insheet using FPL16-GW`i'.csv,clear
	drop gw*forecast nextfixture*
	gen GameWeek = `i'
	append using HistFPL16
	//SAVE
	save HistFPL16,replace
	}
gen Season = 16
save HistFPL16,replace

*Create historical data using FPL Season 17-18
insheet using FPL17-GW0.csv,clear
drop gw*forecast nextfixture*
gen GameWeek = 0

//SAVE
save HistFPL17,replace

forvalues i = 0/37 {
	insheet using FPL17-GW`i'.csv,clear
	drop gw*forecast nextfixture*
	gen GameWeek = `i'
	append using HistFPL17
	save HistFPL17,replace
	}
//REPLACE
replace GameWeek = GameWeek+1
gen Season = 17

append using HistFPL16
compress
replace eaindex =. if Season==17
gen match_code = .
do MatchCodes_ab.do

gen PlayerName = firstname + " " + surname 
do PlayerNameCorrection.do

//SAVE
save HistFPL1617,replace	

/*******************************************************************************

Premier League Season 2017/2018

********************************************************************************/

import excel using FPL_api,sheet(Fixtures1718) clear first

replace Home = subinstr(Home," ","",1)

do MatchCodes.do

ren Date date_str
gen Date = date(date_str,"DMY")
format Date %td
drop date_str

foreach var of varlist Home Away { 
	tab `var' if missing(`var'_code)
	}

//SAVE	
save Fixtures1718,replace

use HistFPL1617,clear
drop if Season==16

ren match_code Home_code

merge m:1 Home_code GameWeek using Fixtures1718, nogen
ren Home AsHome
ren Away OppositionAsHome
drop Away_code
ren Date HomeDate
ren Home_code Away_code

merge m:1 Away_code GameWeek using Fixtures1718, nogen
drop Home_code
ren Away AsAway
ren Home OppositionAsAway
ren Date AwayDate
ren Away_code match_code

ren HomeDate Date
replace Date = AwayDate if Date==.
drop AwayDate
duplicates drop firstname surname team cost totalpoints GameWeek Season match_code PlayerName Date,force
//SAVE
save HistFPL17Fixtures,replace

/*******************************************************************************

Premier League Season 2016/2017

********************************************************************************/

import excel using FPL_api,sheet(Fixtures1617) clear first

replace Home = trim(Home)
replace Away = trim(Away)

*Gen new team codes
do MatchCodes.do

*Check that all teams have codes
foreach var of varlist Home Away { 
	tab `var' if missing(`var'_code)
	}
	
	
//SAVE
save Fixtures1617,replace


//USE
use HistFPL1617,clear
drop if Season==17

tab team if missing(match_code)

ren match_code Home_code

merge m:1 Home_code GameWeek using Fixtures1617, nogen keep(1 3)
ren Home AsHome
ren Away OppositionAsHome
ren Date HomeDate
drop Away_code

ren Home_code Away_code

merge m:1 Away_code GameWeek using Fixtures1617, nogen keep(1 3)
drop Home_code
ren Away AsAway
ren Home OppositionAsAway
ren Date AwayDate

ren Away_code match_code
ren HomeDate Date
replace Date = AwayDate if Date==.
drop AwayDate
duplicates drop firstname surname team cost totalpoints GameWeek Season match_code PlayerName Date,force
//SAVE
save HistFPL16Fixtures,replace
