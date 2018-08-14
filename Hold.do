use HistFPL1617,clear
gen PlayerName = firstname + " " + surname

drop if Season==16

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

use HistFPL1617,clear
drop if inlist(Season,16,.)
gen PlayerName = firstname + " " + surname

egen id = group(PlayerName)
duplicates report id
tsset id GameWeek

encode team,gen(teamid)

reg totalpoints ictindex, a(GameWeek) fe2(teamid)

gen PredictScoresICT = _b[ictindex]*ictindex
sum PredictScoresICT  totalpoints

gen pointsdiff = totalpoints-PredictScoresICT  

tabstat PredictScoresICT totalpoints pointsdiff if GameWeek ==3,by(PlayerName) s(mean)

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
