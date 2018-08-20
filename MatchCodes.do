

loc side = "Home Away"
foreach var of local side {
	gen `var'_code =.
	replace `var'_code =1 if `var'=="Arsenal"
	replace `var'_code =2 if `var'=="Brighton and Hove Albion"
	replace `var'_code =3 if `var'=="Bournemouth"
	replace `var'_code =4 if `var'=="Burnley"
	replace `var'_code =5 if `var'=="Chelsea"
	replace `var'_code =6 if `var'=="Crystal Palace"
	replace `var'_code =7 if `var'=="Everton"
	replace `var'_code =8 if `var'=="Huddersfield Town"
	replace `var'_code =9 if `var'=="Hull City"
	replace `var'_code =10 if `var'=="Leicester City"
	replace `var'_code =11 if `var'=="Liverpool"
	replace `var'_code =12 if `var'=="Manchester City"
	replace `var'_code =13 if `var'=="Middlesbrough"
	replace `var'_code =14 if `var'=="Manchester United"
	replace `var'_code =15 if `var'=="Newcastle United"
	replace `var'_code =16 if `var'=="Southampton"
	replace `var'_code =17 if `var'=="Stoke City"
	replace `var'_code =18 if `var'=="Sunderland"
	replace `var'_code =19 if `var'=="Swansea City"
	replace `var'_code =20 if `var'=="Tottenham Hotspur"
	replace `var'_code =21 if `var'=="Watford"
	replace `var'_code =22 if `var'=="West Bromwich Albion"
	replace `var'_code =23 if `var'=="West Ham United"
	}
