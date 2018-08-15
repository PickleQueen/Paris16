use HistFPL1617,clear
drop if inlist(Season,16,.)
*gen i_Season=(Season==17)
*keep if GameWeek==37
gen PlayerName = firstname + " " + surname

tabstat totalpoints if GameWeek==36,by(PlayerName) s(mean)
tabstat totalpoints,by(PlayerName) s(mean)

encode team,gen(teamid)
egen id = group(PlayerName)
duplicates report id
tsset id GameWeek

bysort id: gen pointchange = f.totalpoints-totalpoints
bysort id: gen valuechange = f.valueform-valueform

gen t1 = selectedbypercent if GameWeek==1
gen t2 = valueform if GameWeek==1
bysort id: egen selectedbypercent1 = max(t1) 
bysort id: egen valueform1 = max(t2) 
drop t1 t2

erase HistParameter.txt
forvalues i = 1/37 {
	qui areg totalpoints selectedbypercent1 valueform1 if GameWeek==`i',r a(teamid)
	outreg2 using HistParameter,append
	}
	
* _b[selectedbypercent ] = .1415292
* _b[valueform] = 9.846862
capture drop PredictScores
gen PredictScores = _b[selectedbypercent]*selectedbypercent + _b[valueform]*valueform 
/* + /// 
_b[_Iteamid_2]*_Iteamid_2 + /// 
_b[_Iteamid_3]*_Iteamid_3 + /// 
_b[_Iteamid_4]*_Iteamid_4 + /// 
_b[_Iteamid_5]*_Iteamid_5 + /// 
_b[_Iteamid_6]*_Iteamid_6 + /// 
_b[_Iteamid_7]*_Iteamid_7 + /// 
_b[_Iteamid_8]*_Iteamid_8 + /// 
_b[_Iteamid_9]*_Iteamid_9 + /// 
_b[_Iteamid_10]*_Iteamid_10 + /// 
_b[_Iteamid_11]*_Iteamid_11 + /// 
_b[_Iteamid_12]*_Iteamid_12 + /// 
_b[_Iteamid_13]*_Iteamid_13 + /// 
_b[_Iteamid_14]*_Iteamid_14 + /// 
_b[_Iteamid_15]*_Iteamid_15 + /// 
_b[_Iteamid_16]*_Iteamid_16 + /// 
_b[_Iteamid_17]*_Iteamid_17 + /// 
_b[_Iteamid_18]*_Iteamid_18 + /// 
_b[_Iteamid_19]*_Iteamid_19 + /// 
_b[_Iteamid_20]*_Iteamid_20
*/

tabstat totalpoints PredictScores if GameWeek==2,by(PlayerName) s(mean)


bysort GameWeek: egen TotGWScores = mean(totalpoints)
bysort GameWeek positionslist: egen PosGWScores = mean(totalpoints)
gen GkShare = PosGWScores/TotGWScores if positionslist == "GLK"
gen DefShare = PosGWScores/TotGWScores if positionslist == "DEF"
gen MidShare = PosGWScores/TotGWScores if positionslist == "MID"
gen FwdShare = PosGWScores/TotGWScores if positionslist == "FWD"

twoway (scatter GkShare GameWeek,c(l)) ///
	(scatter DefShare GameWeek,c(l)) ///
	(scatter MidShare GameWeek,c(l)) ///
	(scatter FwdShare GameWeek,c(l))

*Alonso
scatter pointchange GameWeek if surname=="Alonso",c(l)
*Kante
scatter pointchange GameWeek if surname=="Kante",c(l)
*Wan-Bissaka
scatter pointchange GameWeek if surname=="Wan-Bissaka",c(l)
*Zaha
scatter pointchange GameWeek if surname=="Zaha",c(l)
*Robertson
scatter pointchange GameWeek if surname=="Robertson",c(l)
*Mané
scatter pointchange GameWeek if surname=="Mane",c(l)
*Salah
scatter pointchange GameWeek if surname=="Salah",c(l)
*Firmino
scatter pointchange GameWeek if surname=="Firmino",c(l)
*Santana
scatter pointchange GameWeek if surname=="Ederson",c(l)
*Mendy
scatter pointchange GameWeek if surname=="Mendy",c(l) sort
*Aguero
scatter pointchange GameWeek if surname=="Aguero",c(l)
*De Gea
scatter pointchange GameWeek if surname=="De Gea",c(l)
*Holebas
scatter pointchange GameWeek if surname=="Holebas",c(l)
*Pereyra
scatter pointchange GameWeek if surname=="Pereyra",c(l)
*Neves
scatter pointchange GameWeek if surname=="Neves",c(l)
*Wilson
scatter pointchange GameWeek if surname=="Wilson",c(l) sort
*Yerry Mina
scatter pointchange GameWeek if surname=="Mina",c(l) sort
*Alli
scatter pointchange GameWeek if surname=="Alli",c(l) sort

gen PredictList = 0
do Top15Program.do
glo xconditions Season==17&GameWeek==37&PredictList!= 1
do Top15Program.do

tab PlayerName if PredictList==1

tab PredictList HistList
tab PlayerName PredictList if PredictList==1|HistList==1


forvalues i = 1/37 {
	gen L`i'_PredictScores = PredictScores[_n+`i']
	}
corr PredictScores L*_PredictScores

forvalues i = 1/37 {
	gen L`i'_valueform = valueform[_n+`i']
	}
corr valueform L*_valueform
