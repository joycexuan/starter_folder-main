library(opendatatoronto)
library(dplyr)
library(tidyverse)
library(janitor)
library(knitr)

assaults <- read_csv("~/Desktop/starter_folder-main/inputs/data/cleaned_assault_data.csv")

##selecting neighbourhood name, 2020 assault amounts and 2021 assault amounts
assaults <- assault_data |> select(HoodName, Assault_2020, Assault_2021)
##selecting assaults that are above 400 from both 2020 and 2021
assaults <- assaults|>filter(Assault_2020 > 400, Assault_2021 > 400)
write_csv(assaults, "~/Desktop/starter_folder-main/inputs/data/final_assault_data.csv")
##pivoting the data set so that it is easily graphable by assault year
filter_assaults <- assaults |> pivot_longer(cols=c("Assault_2020", "Assault_2021"), 
                                            names_to = "assault_year", 
                                            values_to = "assault_amt")

##renaming columns so they are more elegant
filter_assaults <- filter_assaults |>
  rename(
    Neighbourhood = HoodName,
    Assault_Number = assault_amt,
    Assault_Year = assault_year
  )

##renaming a neighbourhood so its shorter
filter_assaults <- filter_assaults |> 
  mutate(
    Neighbourhood =
      recode(Neighbourhood,
        "Waterfront Communities-The Island" = "Waterfront-Island"
      )
  )

##changing assault year variable so it is more elegant
filter_assaults <- filter_assaults |>
  mutate(
    Assault_Year =
      recode(
        Assault_Year,
        "Assault_2020" = "2020",
        "Assault_2021" = "2021"
      )
  )


##selecting Church-Yonge neighbourhood, 2014-2021 assault amounts 
churchy <- assault_data |> filter(X_id == 23) |> select(Assault_2014, Assault_2015, Assault_2016, Assault_2017, Assault_2018, Assault_2019, Assault_2020, Assault_2021)
churchy <- as.data.frame(t(churchy))

years <- c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021)
churchy$year <- years 

colnames(churchy) <- c("assaults", "years")
rownames(churchy) <- c(1:nrow(churchy))
                       

#linegraph with Church-Yonge neighbourhood 2014-2021 assaults
ggplot(churchy, aes(x= years)) + 
  geom_line(aes(y = churchassaults), color = "darkred")

#Saving churchy to inputs
write_csv(churchy, "~/Desktop/starter_folder-main/inputs/data/churchdata.csv")






