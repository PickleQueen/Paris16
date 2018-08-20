*Def and Mid have a larger share of the total points because they are more.
bysort gameweek: egen TotGWScores = total(GWScores)
bysort gameweek element_typ: egen PosGWScores = total(GWScores)
gen PosGWScoresSh = PosGWScores/TotGWScores
tabstat PosGWScoresSh if gameweek ==1,by(element_type ) s(mean)

gen GkShare = PosGWScores/TotGWScores if element_type==1
gen DefShare = PosGWScores/TotGWScores if element_type==2
gen MidShare = PosGWScores/TotGWScores if element_type==3
gen FwdShare = PosGWScores/TotGWScores if element_type==4

twoway (scatter GkShare gameweek,c(l)) ///
	(scatter DefShare gameweek,c(l)) ///
	(scatter MidShare gameweek,c(l)) ///
	(scatter FwdShare gameweek,c(l))
