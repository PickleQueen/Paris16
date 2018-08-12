cd "C:\Users\lujn\Desktop\FPL"
import excel using "Fixtures 18-19",describe
import excel using "Fixtures 18-19",sheet("Fixtures wins") clear first
replace Rounds = subinstr(Rounds,"Round","",.)
destring Round,replace

*Rename team names
foreach var of varlist Home Away {
	replace `var' = "Huddersfield" if `var'=="Huddersfield Town"
	replace `var' = "Man Utd" if `var'=="Manchester United"
	replace `var' = "Man Utd" if `var'=="Manchester Utd"
	replace `var' = "Man City" if `var'=="Manchester City"
	replace `var' = "Newcastle" if `var'=="Newcastle United"
	replace `var' = "Spurs" if `var'=="Tottenham Hotspur"
	replace `var' = "Spurs" if `var'=="Tottenham"
	replace `var' = "Brighton" if `var'=="Brighton & Hove Albion"
	replace `var' = "Leicester" if `var'=="Leiceister City"
	replace `var' = "Wolves" if `var'=="Wolverhampton Wanderers"
	replace `var' = "Cardiff" if `var'=="Cardiff City"
	}

preserve
keep HomeWin Home Round
gen HomeMatch = 1
reshape wide HomeWin HomeMatch,i(Home) j(Round)
ren Home teamvar_name
save HomeScores,replace
restore,preserve

keep AwayWin Away Round	
gen AwayMatch = 1
reshape wide AwayWin AwayMatch,i(Away) j(Round)
ren Away teamvar_name
save AwayScores,replace
restore,preserve

keep Draw Round	Home
reshape wide Draw,i(Home) j(Round)
ren Home teamvar_name
save DrawScores,replace
restore,preserve

* By Game weeks
drop Away AwayWin
ren Home teamvar_name
merge 1
