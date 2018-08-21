foreach var of varlist * {
	ren `var' `=subinstr("`var'","Column1","",1)'
	}

lab var total_points "Total score"
lab var event_points "Round score"
lab var now_cost "Price"
lab var selected_by_percent "Teams selected by %"
lab var minutes "Minutes played"
lab var goals_scored "Goals scored"
lab var assists "Assists"
lab var clean_sheets "Clean sheets"
lab var goals_conceded "Goals conceded"
lab var own_goals "Own goals"
lab var penalties_saved "Penalties saved"
lab var penalties_missed "Penalties missed"
lab var yellow_cards "Yellow cards"
lab var red_cards "Red cards"
lab var saves "Saves"
lab var bonus "Bonus"
lab var bps "Bonus Points System"
lab var influence "Influence"
lab var creativity "Creativity"
lab var threat "Threat"
lab var ict_index "ICT Index"
lab var form "Form"
lab var dreamteam_count "Times in Dream Team"
lab var value_form "Value (form)"
lab var value_season "Value (season)"
lab var points_per_game "Points per match"
lab var transfers_in "Transfers in"
lab var transfers_out "Transfers out"
lab var transfers_in_event "Transfers in (round)"
lab var transfers_out_event "Transfers out (round)"
lab var cost_change_start "Price rise"
lab var cost_change_start_fall "Price fall"
lab var cost_change_event "Price rise (round)"
lab var cost_change_event_fall "Price fall (round)"

*Team names
replace teamvar_name = "Arsenal" if team_code== 3
replace teamvar_name = "Bournemouth" if team_code== 91
replace teamvar_name = "Brighton" if team_code== 36
replace teamvar_name = "Burnley" if team_code== 90
replace teamvar_name = "Cardiff" if team_code== 97
replace teamvar_name = "Chelsea" if team_code== 8
replace teamvar_name = "Crystal Palace" if team_code== 31
replace teamvar_name = "Everton" if team_code== 11
replace teamvar_name = "Fulham" if team_code== 54
replace teamvar_name = "Huddersfield" if team_code== 38
replace teamvar_name = "Leicester" if team_code== 13
replace teamvar_name = "Liverpool" if team_code== 14
replace teamvar_name = "Man City" if team_code== 43
replace teamvar_name = "Man Utd" if team_code== 1
replace teamvar_name = "Newcastle" if team_code== 4
replace teamvar_name = "Southampton" if team_code== 20
replace teamvar_name = "Spurs" if team_code== 6
replace teamvar_name = "Watford" if team_code== 57
replace teamvar_name = "West Ham" if team_code== 21
replace teamvar_name = "Wolves" if team_code== 39

