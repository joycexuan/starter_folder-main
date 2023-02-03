library(opendatatoronto)
library(dplyr)
library(tidyverse)
library(janitor)
library(knitr)

assaults <- read.csv("~/Desktop/starter_folder-main/inputs/data/cleaned_assault_data.csv")

##selecting neighbourhood name, 2020 assault amounts and 2021 assault amounts
assaults <- assault_data |> select(HoodName, Assault_2020, Assault_2021)
##selecting assaults that are above 400 from both 2020 and 2021
assaults <- assaults|>filter(Assault_2020 > 400, Assault_2021 > 400)

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


##making a bar graph with everything
ggplot(filter_assaults, aes(x = Neighbourhood, 
                            y=Assault_Number, fill=Assault_Year)) + 
  geom_bar (stat="identity", position="dodge")+ 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.8, hjust = 0.8))

write.csv(filter_assaults, "~/Desktop/starter_folder-main/inputs/data/cleaned_assault_data.csv", row.names=FALSE)

##selecting Church-Yonge neighbourhood, 2014-2021 assault amounts 
churchy <- assault_data |> filter(X_id == 23) |> select(Assault_2014, Assault_2015, Assault_2016, Assault_2017, Assault_2018, Assault_2019, Assault_2020, Assault_2021)

years <- c(2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021)

churchassaults <- c(537, 551, 594, 749, 809, 909, 767, 966)

churchy <- data.frame(years, churchassaults)

#linegraph with Church-Yonge neighbourhood 2014-2021 assaults
ggplot(churchy, aes(x= years)) + 
  geom_line(aes(y = churchassaults), color = "darkred")

#Saving churchy to inputs
write.csv(churchy, "~/Desktop/starter_folder-main/inputs/data/churchdata.csv", row.names = FALSE)






