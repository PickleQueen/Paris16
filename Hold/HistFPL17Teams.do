
use HistFPL17Fixtures,clear

bysort AsHome: egen AsHomeAvgVAL = mean(valueform) if AsHome!=""
bysort AsAway: egen AsAwayAvgVAL = mean(valueform) if AsAway!=""
bysort OppositionAsHome: egen OppAsHomeAvgVAL = mean(valueform)  if OppositionAsHome!=""
bysort OppositionAsAway: egen OppAsAwayAvgVAL = mean(valueform)  if OppositionAsAway!=""

gen DiffAsHomeVAL = AsHomeAvgVAL-OppAsHomeAvgVAL
