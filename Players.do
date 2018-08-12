
cd "C:\Users\lujn\Desktop\FPL\Paris16"
import excel using FPL_api,describe
import excel using FPL_api,sheet(FPL_api) clear first

gen teamvar_name = ""
gen WorstPicks = 0

do RenVar.do
do Destring.do
do WorstPicks.do

/*
DEFINITIONS

Value (season) is quite simply total points/price.
Value (form) is Form/Price. Form is points per game over all matches the club has played in the last 30 days
*/

* Play at least 60 min
gen at60min = (minutes>60)
reg at60min now_cost influence creativity threat ict_index value_form,r

* ["element_type"], i.e. 1 = Goalkeeper, 2 = Defender, 3 = Midfielder, 4 = Forward
*My Team GW1
gen fantasyteam = 0
replace fantasyteam = 1 if web_name == "De Gea"
replace fantasyteam = 1 if web_name == "Cresswell"
replace fantasyteam = 1 if web_name == "Robertson"
replace fantasyteam = 1 if web_name == "Coleman"
replace fantasyteam = 1 if web_name == "Doherty"
replace fantasyteam = 1 if web_name == "Jota"
replace fantasyteam = 1 if web_name == "Milivojevic"
replace fantasyteam = 1 if web_name == "Cairney"
replace fantasyteam = 1 if web_name == "Bernardo Silva"
replace fantasyteam = 1 if code == 37572 //Agüero
replace fantasyteam = 1 if web_name == "Aubameyang"
replace fantasyteam = 1 if web_name == "Boruc"
replace fantasyteam = 1 if web_name == "Alexander-Arnold"
replace fantasyteam = 1 if web_name == "Richarlison"
replace fantasyteam = 1 if web_name == "Firmino"

*CHECK THE IMPORTANCE OF VARIABLES CALIBRATED ON THE DREAM TEAM  
reg in_dreamteam influence creativity threat ict_index value_form total_points




*PREDICT TEAM FOR GAME WEEK


*1 = Goalkeeper, 2 = Defender, 3 = Midfielder, 4 = Forward
pca influence creativity threat ict_index value_form total_points
predict pca

corr fantasyteam in_dreamteam pca
glo xconditions chance_of_playing_next_r>=100

gen pcateam = 0
*Goalies (2)
sum pca if element_type==1&$xconditions
replace pcateam = 1 if pca==r(max)
sum pca if element_type==1&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

*Defenders (5)
sum pca if element_type==2&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==2&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==2&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==2&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==2&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

*Midfielders (5)
sum pca if element_type==3&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==3&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==3&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==3&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==3&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

*Strikers (3)
sum pca if element_type==4&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==4&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

sum pca if element_type==4&pcateam != 1&$xconditions
replace pcateam = 1 if pca==r(max)

tabstat pca now_cost if pcateam==1,by(web_name) s(sum)
tab web_name if pcateam==1
tabstat pca now_cost if element_type==1,by(web_name) s(sum)

*Manage to predict 10 of 15 in the FPL Dream Team using PCA.
*Or 8 if excluding players with lower than 100% chance of playing next round..
tab web_name if in_dreamteam==1&pcateam==1

*Check the condition of max 3 players from the same club
tab teamvar_name if pcateam==1

/* IF MORE THAN 3 PLAYERS FROM THE SAME CLUB, MAKE TRANSFERS HERE!



tab web_name element_type if teamvar_name=="Crystal Palace"&pcateam==1
tabstat element_type if teamvar_name=="Crystal Palace"&pcateam==1

tab web_name if pcateam
tabstat now_cost pca2 if pcateam,by(web_name) s(sum)
tabstat now_cost pca2 if teamvar_name=="Crystal Palace"&pcateam==1,by(web_name) s(sum)

tab teamvar_name if web_name == "Foster"

replace pcateam = 0 if web_name == "Hennessey"
replace pcateam = 1 if web_name == "Foster"

tabstat now_cost if pcateam==1,by(web_name) s(sum N)

*/



*High picks
/*
Fraser
Etheridge (G)
Foster (G*)
Holebas
Neves
Pereyra
Schlupp
Shaw
Wan-Bissaka
Wilson
van Aanholt
*/

*Low picks
/*
Alli
Jiménez
Joselu
Vertonghen
*/

*Transfer out
/*
Richarlison*
Hennessey (G)
*/

save players,replace
