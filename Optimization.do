*Create the constraints
gen num_gk = 2
gen num_def = 5
gen num_mid = 5
gen num_fwd = 3
gen max_cost = 100
* Create vectors to constrain by position
df$Goalkeeper = ifelse(df$type_name == "Goalkeeper", 1, 0)
df$Defender = ifelse(df$type_name == "Defender", 1, 0)
df$Midfielder = ifelse(df$type_name == "Midfielder", 1, 0)
df$Forward = ifelse(df$type_name == "Forward", 1, 0)
# Create vector to constrain by max number of players allowed per team
team_constraint = unlist(lapply(unique(df$team_name), function(x, df){
ifelse(df$team_name==x, 1, 0)
}, df=df))
# next we need the constraint directions
const_dir <- c("=", "=", "=", "=", rep("<=", 21))
