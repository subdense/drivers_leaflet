#combine datasets for leaflet
library(sf)
library(dplyr)

# Read the GeoPackage layer
str_sf <- st_read("C:/Users/Vera/Documents/SUBDENSE/Projects/CompareDrivers_Countries/R Outputs/str_ha_drivers.gpkg") %>% 
  st_transform(crs = 3035) %>%
  select(c(amenity_count, m_to_train, m_to_park, total_area2011, cci, total_volume_new))
dor_sf <- st_read("C:/Users/Vera/Documents/SUBDENSE/Projects/CompareDrivers_Countries/R Outputs/dor_ha_drivers.gpkg") %>% 
  st_transform(crs = 3035) %>%
  select(c(amenity_count, m_to_train, m_to_park, total_area2011, cci, total_volume_new))
liv_sf <- st_read("C:/Users/Vera/Documents/SUBDENSE/Projects/CompareDrivers_Countries/R Outputs/liv_ha_drivers.gpkg") %>% 
  st_transform(crs = 3035) %>%
  select(c(amenity_count, m_to_train, m_to_park, total_area2011, cci, total_volume_new))

polygon_sf <- bind_rows(str_sf, dor_sf, liv_sf)

# Function to get the lower-left coordinates of the bounding box
get_lower_left <- function(geom) {
  bbox <- st_bbox(geom)
  return(c(x = bbox["xmin"], y = bbox["ymin"]))
}

# Apply the function to each geometry to get the lower-left coordinates
lower_left_coords <- st_geometry(polygon_sf) %>%
  lapply(get_lower_left) %>%
  do.call(rbind, .) %>%
  as_tibble()

# Rename the columns for clarity
lower_left_coords <- lower_left_coords %>%
  rename(x = x.xmin, y = y.ymin)

# Combine the coordinates with the original attributes (excluding geometry)
polygon_attributes <- polygon_sf %>%
  st_drop_geometry()

final_data <- bind_cols(polygon_attributes, lower_left_coords)

# Write the data to a CSV file
write.csv(final_data, "C:/Users/Vera/Documents/SUBDENSE/Projects/CompareDrivers_Countries/drivers_leaflet/drivers.csv", row.names = FALSE)
