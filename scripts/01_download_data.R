library(opendatatoronto)
library(dplyr)

# get package
package <- show_package("neighbourhood-crime-rates")
package

# get all resources for this package
resources <- list_package_resources("neighbourhood-crime-rates")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv'))

# load the first datastore resource as a sample
assault_data <- filter(datastore_resources, row_number()==1) %>% get_resource()
assault_data

#save data set 
write_csv(assault_data, "~/Desktop/starter_folder-main/inputs/data/rawdata.csv")


