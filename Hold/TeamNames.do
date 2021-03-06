
replace Home = trim(Home)

gen team=""
replace team ="ARS" if Home =="Arsenal"
replace team ="BHA" if Home =="Brighton and Hove Albion"
replace team ="BOU" if Home =="Bournemouth"
replace team ="BUR" if Home =="Burnley"
replace team ="CHE" if Home =="Chelsea"
replace team ="CRY" if Home =="Crystal Palace"
replace team ="EVE" if Home =="Everton"
replace team ="HUD" if Home =="Huddersfield Town"
replace team ="LEI" if Home =="Leicester City"
replace team ="LIV" if Home =="Liverpool"
replace team ="MCI" if Home =="Manchester City"
replace team ="MUN" if Home =="Manchester United"
replace team ="NEW" if Home =="Newcastle United"
replace team ="SOU" if Home =="Southampton"
replace team ="STK" if Home =="Stoke City"
replace team ="SUN" if Home =="Sunderland"
replace team ="SWA" if Home =="Swansea City"
replace team ="TOT" if Home =="Tottenham Hotspur"
replace team ="WAT" if Home =="Watford"
replace team ="WBA" if Home =="West Bromwich Albion"
replace team ="WHU" if Home =="West Ham United"
replace team ="MID" if Home =="Middlesbrough"
replace team ="HUL" if Home =="Hull City"

gen Home = ""
replace Home ="Arsenal" if team=="ARS"
replace Home ="Brighton and Hove Albion" if team=="BHA"
replace Home ="Bournemouth" if team=="BOU"
replace Home ="Burnley" if team=="BUR"
replace Home ="Chelsea" if team=="CHE"
replace Home ="Crystal Palace" if team=="CRY"
replace Home ="Everton" if team=="EVE"
replace Home ="Huddersfield Town" if team=="HUD"
replace Home ="Hull City" if team=="HUL"
replace Home ="Leicester City" if team=="LEI"
replace Home ="Liverpool" if team=="LIV"
replace Home ="Manchester City" if team=="MCI"
replace Home ="Middlesbrough" if team=="MID"
replace Home ="Manchester United" if team=="MUN"
replace Home ="Newcastle United" if team=="NEW"
replace Home ="Southampton" if team=="SOU"
replace Home ="Stoke City" if team=="STK"
replace Home ="Sunderland" if team=="SUN"
replace Home ="Swansea City" if team=="SWA"
replace Home ="Tottenham Hotspur" if team=="TOT"
replace Home ="Watford" if team=="WAT"
replace Home ="West Bromwich Albion" if team=="WBA"
replace Home ="West Ham United" if team=="WHU"
