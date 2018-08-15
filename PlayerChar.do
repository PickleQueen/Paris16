cd "$WorkingDirectory"
import excel using FPL_api,describe
import excel using FPL_api,sheet(PlayerChar) clear first
replace Team = trim(Team)
ren Team teamvar_name


gen Birthday = date(DateofBirth,"MDY")
format Birthday %td
gen BirthYear = year(Birthday)
gen Age = 2018-BirthYear

save PlayerChar,replace
