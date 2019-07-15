library(tidyverse)
library(sf)

# load data
mtn_trips <- bind_rows(
  read_csv('data/mountain_trips/gen1_mountain_once_trips.csv'),
  read_csv('data/mountain_trips/gen2_mountain_once_trips.csv'))

# identify keeper variables
id_vars <- c('id')

# pull out only keeper variables and LL, convert to long (one row for each LL pair)
mtn_trips_long <- mtn_trips %>% 
  select(one_of(id_vars),
         start_lat    = `location[start][latitude]`,
         start_lon    = `location[start][longitude]`,
         end_lat      = `location[end][latitude]`,
         end_lon      = `location[end][longitude]`,
         farthest_lat = `location[farthest][latitude]`,
         farthest_lon = `location[farthest][longitude]`) %>% 
  # convert whole thing to long (one row for each lat or lon coordinate)
  gather('coord','val', -one_of(id_vars)) %>% 
  # split, e.g., start_lat column into start | lat columns
  separate(coord, c('event','coord')) %>% 
  # line lat and lon coords up next to each other
  spread(coord, val) %>% 
  # remove NA events
  filter(!is.na(lat), !is.na(lon))

# make into spatial data, reproject to 4269 (NAD83 LL) from 4326 (WGS84 LL, should check!)
mtn_trips_sf <- mtn_trips_long %>% 
  st_as_sf(coords=c('lon', 'lat'), crs=4326)

mtn_trips_sf %>% write_sf('data/mountain_trips/mountain_trips_LL.shp')



