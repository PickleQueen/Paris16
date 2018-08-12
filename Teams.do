cd "C:\Users\lujn\Desktop\FPL"
import excel using FPL_api,describe
import excel using FPL_api,sheet(Teams) clear first
do RenVar.do

foreach var of varlist * {
	ren `var' teamvar_`var'
	}

ren teamvar_code team_code
save teams,replace
