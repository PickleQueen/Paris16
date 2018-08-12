cd "C:\Users\lujn\Desktop\FPL\Paris16"
import excel using FPL_api,describe
import excel using FPL_api,sheet(PlayerChar) clear first
replace Team = trim(Team)
ren Team teamvar_name
replace PlayerName = "Younes Kaboul" if PlayerName=="Younès Kaboul"
replace PlayerName = "Pierre-Emile Højbjerg" if PlayerName=="Pierre-Emile Höjbjerg"
replace PlayerName = "Alexander Sørloth" if PlayerName=="Alexander Sörloth"

gen Birthday = date(DateofBirth,"MDY")
format Birthday %td
gen BirthYear = year(Birthday)
gen Age = 2018-BirthYear

save PlayerChar,replace
