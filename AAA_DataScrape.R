library(baseballr)
library(tidyverse)

schedule_data <- mlb_schedule(season = 2023, level_ids = "11")

all_game_pks <- unique(schedule_data$game_pk)
all_data <- list()

for (game_pk in all_game_pks) {
  fetched_data <- tryCatch({
    mlb_pbp(game_pk)
  },
  error = function(e) {
    message(paste("Error fetching data for game_pk:", game_pk, ". Error message:", e$message))
    return(NULL)
  })
 
  if (!is.null(fetched_data)) {
    all_data <- append(all_data, list(fetched_data))
  }
  
}

combined_data <- bind_rows(all_data)
write.csv(combined_data, file = "~/Desktop/AAA_data.csv", row.names = FALSE)
