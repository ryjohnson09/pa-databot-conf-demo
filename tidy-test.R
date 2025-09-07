install.packages("tidytuesdayR")

# Load Data
my_data <- tidytuesdayR::tt_load(2025, week = 6)

# Data quality issues
my_data$cdc_datasets |> 
  count(public_access_level, sort = TRUE)

# Update frequency patterns
my_data$cdc_datasets |> 
  count(update_frequency, sort = TRUE)

# Geographic coverage
my_data$cdc_datasets |> 
  count(geographic_coverage, sort = TRUE)

# Contact consolidation
my_data$cdc_datasets |> 
  group_by(contact_name) |> 
  summarise(datasets = n()) |> 
  arrange(desc(datasets))

# Look at the relationship between missing data and categories
my_data$cdc_datasets |>
  group_by(category) |>
  summarise(
    total = n(),
    missing_access = sum(is.na(public_access_level)),
    missing_freq = sum(is.na(update_frequency)),
    missing_geo = sum(is.na(geographic_coverage))
  ) |>
  mutate(across(starts_with("missing"), ~ round(.x/total * 100, 1))) |>
  arrange(desc(total))