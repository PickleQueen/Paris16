use HistFPL1617,clear
gen PlayerName = firstname + " " + surname

drop if Season==16


scatter totalpoints GameWeek if surname=="Wan-Bissaka",c(1)


keep if inlist(GameWeek,1,2)
tab team,gen(i_team)
gen GameWeek2Forecast = totalpoints if GameWeek==1

corr GameWeek2Forecast ictindex selectedbypercent cost bps pricerise pricefall

mdesc GameWeek2Forecast
mi set mlong
mi register imputed GameWeek2Forecast

mi impute pmm GameWeek2Forecast, by(positionslist) rseed(53421) add(50) knn(5)

gen GameWeek2ForecastRound = round(GameWeek2Forecast)
gen pointsdiff = totalpoints-GameWeek2ForecastRound

tabstat GameWeek2ForecastRound totalpoints pointsdiff if Season ==17&GameWeek ==2,by(PlayerName) s(mean)


*Out-of-sample prediction with regress




twoway (scatter AvgPointChange GameWeek if HistListMax==1,c(l)) ///
	(scatter TotPointChange GameWeek if HistListMax==1,c(l) yaxis(2) ylab(,angle(0) axis(2)) ), /// 
	graphregion(col(white)) xlab(1(1)37,labsize(tiny)) ylab(,angle(0))

twoway (scatter AvgPointChange GameWeek if HistListMax==0&GameWeek<28,c(l)) ///
	(scatter TotPointChange GameWeek if HistListMax==0&GameWeek<28,c(l) yaxis(2) ylab(,angle(0) axis(2)) ), /// 
	graphregion(col(white)) xlab(1(1)37,labsize(tiny)) ylab(,angle(0))

	
graph export PointChangeS17.tif,replace	
	
twoway (scatter TotPointChange GameWeek if HistListMax==1&GameWeek<28,c(l)) ///
	(scatter TotPointChange GameWeek if HistListMax==1&GameWeek<28,c(l) yaxis(2) ylab(,angle(0) axis(2)) ), /// 
	graphregion(col(white)) xlab(1(1)37,labsize(tiny)) ylab(,angle(0))

twoway (scatter TotPointChange GameWeek if HistListMax==0&GameWeek<28,c(l)) ///
	(scatter TotPointChange GameWeek if HistListMax==0&GameWeek<28,c(l) yaxis(2) ylab(,angle(0) axis(2)) ), /// 
	graphregion(col(white)) xlab(1(1)37,labsize(tiny)) ylab(,angle(0))
	
scatter TotPointChange GameWeek if surname=="Aguero",c(l)	
	
*ren ictindex ict_index
*ren totalpoints total_points
capture drop PredictICTPoints pointsdiff
reghdfe totalpoints ict_index, a(GameWeek)
predict PredictICTPoints
predict PredictICTVar,stdp

drop coeff
gen coeff = .
levelsof PlayerName,loc(players)
foreach var of local players {
	areg totalpoints ictindex if GameWeek´i, a(GameWeek)
	replace coeff = _b[ictindex] if PlayerName=="`var'"
	}
bysort PlayerName: gen pointsperict = totalpoints/ictindex
tabstat pointsperict totalpoints pointsdiff,by(PlayerName) s(mean)


gen pointsdiff = totalpoints-CoeffPoints  
gen CoeffPoints = coeff*ictindex
tabstat CoeffPoints totalpoints pointsdiff,by(PlayerName) s(mean)

********************************************************************************
use HistFPL1617,clear
drop if inlist(Season,17,.)
gen PlayerName = firstname + " " + surname

egen id = group(PlayerName)
duplicates report id
tsset id GameWeek

tab team,gen(i_team)

areg totalpoints cost eaindex i_team*,r a(GameWeek)
gen PredictScoresEA = _b[_cons] + _b[eaindex]*eaindex + _b[cost]*cost
sum PredictScoresEA totalpoints

tabstat PredictScoresEA totalpoints if GameWeek ==6,by(PlayerName) s(mean)





*gen ImputeList = 0
*do ImputeList.do 

/*Best 15 players by points
gen HistList = 0
glo xconditions Season==17&GameWeek==37&HistList!= 1
do Top15Program.do

tab PlayerName if HistList==1
bysort PlayerName: egen HistListMax = max(HistList)
tab HistListMax

gen pointchange = f.totalpoints-totalpoints
gen costchange = f.cost-cost

bysort GameWeek HistListMax: egen AvgPointChange = mean(pointchange)
bysort GameWeek HistListMax: egen TotPointChange = sum(pointchange) if !missing(pointchange)

bysort GameWeek HistListMax: egen AvgCostChange = mean(costchange)
bysort GameWeek HistListMax: egen TotCostChange = sum(costchange) if !missing(pointchange)

bysort team GameWeek HistListMax: egen AvgTeamPointChange = mean(pointchange)
bysort team GameWeek HistListMax: egen TotTeamPointChange = sum(pointchange) if !missing(pointchange)

bysort team GameWeek HistListMax: egen AvgTeamCostChange = mean(costchange)
bysort team GameWeek HistListMax: egen TotTeamCostChange = sum(costchange) if !missing(pointchange)
gen cost_th = cost/1000 
*/
