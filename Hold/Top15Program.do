

*Goalies (2)
sum PredictScores if positionslist=="GLK"&Season==17&GameWeek==37
replace PredictList = 1 if PredictScores==r(max)&$xconditions
sum PredictScores if positionslist=="GLK"&$xconditions
replace PredictList = 1 if PredictScores==r(max)&$xconditions

*Defenders (5)
forvalues i = 1/5 {
	sum PredictScores if positionslist=="DEF"&$xconditions
	replace PredictList = 1 if PredictScores==r(max)&$xconditions
	}
*Midfielders (5)
forvalues i = 1/5 {
	sum PredictScores if positionslist=="MID"&$xconditions
	replace PredictList = 1 if PredictScores==r(max)&$xconditions
	}

*Strikers (3)
forvalues i = 1/3 {
	sum PredictScores if positionslist=="FWD"&$xconditions
	replace PredictList = 1 if PredictScores==r(max)&$xconditions
	}
