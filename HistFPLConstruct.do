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
save HistFPL1617,replace	
