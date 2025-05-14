library(sf)
library(dplyr)

# Read the GeoPackage layer
polygons_sf <- st_read("~/Documents/SUBDENSE/Projects/CompareDrivers_Countries/R Outputs/str_ha_drivers.gpkg") %>% 
  st_transform(crs = 3035)

# Function to get the lower-left coordinates of the bounding box
get_lower_left <- function(geom) {
  bbox <- st_bbox(geom)
  return(c(x = bbox["xmin"], y = bbox["ymin"]))
}

# Apply the function to each geometry to get the lower-left coordinates
lower_left_coords <- st_geometry(polygons_sf) %>%
  lapply(get_lower_left) %>%
  do.call(rbind, .) %>%
  as_tibble()

# Rename the columns for clarity
lower_left_coords <- lower_left_coords %>%
  rename(x = x.xmin, y = y.ymin)

# Combine the coordinates with the original attributes (excluding geometry)
polygon_attributes <- polygons_sf %>%
  st_drop_geometry()

final_data <- bind_cols(polygon_attributes, lower_left_coords)

# Write the data to a CSV file
write.csv(final_data, "~/Documents/SUBDENSE/Projects/CompareDrivers_Countries/leaflet_subsense/strasbourg.csv", row.names = FALSE)
