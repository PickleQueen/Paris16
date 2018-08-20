use HistFPL16Fixtures,clear
append using HistFPL17Fixtures

egen id = group(PlayerName match_code Season)
duplicates report id GameWeek

tsset id GameWeek

bysort id: gen pointchange = f.totalpoints-totalpoints
bysort id: gen valuechange = f.valueform-valueform

gen t1 = selectedbypercent if GameWeek==1
gen t2 = valueform if GameWeek==1
*gen t3 = valueform if GameWeek==2
bysort id: egen valueform1 = max(t2) 

bysort id: egen selectedbypercent1 = max(t1) 
drop t1 t2

erase HistParameter.txt
forvalues i = 1/38 {
	qui xi: areg totalpoints cost valueform1 i.Season if GameWeek==`i',r a(match_code)
	outreg2 using HistParameter,append
	}
