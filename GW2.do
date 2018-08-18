
/*
GLK	Ederson Santana
GLK	David De Gea
DEF	Aaron Wan-Bissaka
DEF	Andrew Robertson
DEF Luke Shaw
DEF	José Holebas
DEF	Virgil van Dijk
MID	Christian Eriksen
MID	Richarlison
MID	Mohamed Salah
MID	Bernardo Silva
MID	Roberto Pereyra
FWD	Sergio Agüero
FWD	Wilfried Zaha
FWD	Roberto Firmino
*/
*DEF Cesar Azpilicueta
*replace GW2Team =1 if id==113
*MID	Riyad Mahrez

gen GW2Team = 0
replace GW2Team =1 if id==282
replace GW2Team =1 if id==145
replace GW2Team =1 if id==247
replace GW2Team =1 if id==378
replace GW2Team =1 if id==364
replace GW2Team =1 if id==246
replace GW2Team =1 if id==393
replace GW2Team =1 if id==253
replace GW2Team =1 if id==391
replace GW2Team =1 if id==280
replace GW2Team =1 if id==257
replace GW2Team =1 if id==151
replace GW2Team =1 if id==260
replace GW2Team =1 if id==286
replace GW2Team =1 if id==276


tab PlayerName if GW2Team == 1
tabstat total_points GWScores ict_index value_form if GW2Team == 1&gameweek==2,by(web_name) s(mean)
tabstat total_points GWScores ict_index value_form if PredictOLS == 1&gameweek==2,by(web_name) s(mean)
tabstat total_points GWScores ict_index value_form if in_dreamteam == 1&gameweek==2,by(web_name) s(mean)
tabstat total_points GWScores ict_index value_form if fantasyteam == 1&gameweek==2,by(web_name) s(mean)
