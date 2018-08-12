*Chances of playing next ROUND
tabstat ep_next chance_of_playing_next_r if pcateam,by(web_name ) s(sum)
tabstat ep_next ep_this event_points chance_of_playing_next_r if in_dreamteam ,by(web_name ) s(sum)
tabstat cost_change_start cost_change_start_fall cost_change_event cost_change_event_fall if pcateam,by(web_name ) s(sum)
tabstat minutes goals_scored assists clean_sheets goals_conceded own_goals penalties_saved penalties_missed yellow_cards red_cards saves if in_dreamteam,by(web_name ) s(sum)
tabstat minutes goals_scored assists clean_sheets goals_conceded own_goals penalties_saved penalties_missed yellow_cards red_cards saves if pcateam,by(web_name ) s(sum)

