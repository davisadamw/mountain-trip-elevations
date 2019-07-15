library(tidyverse)

# identify source directory
src_dir <- 'data/test'

# unzip all the rasters in source
map(list.files(src_dir, full.names=T), unzip, exdir=src_dir)

# list all .img files (filenames ending in img) in directory, load them as rasters
test_rasters <- map(list.files(src_dir, 'img$', full.names = T), raster::raster)

# combine all the rasters into one place 
# ... this is a lil time consuming with two, might take longer with more files
# ... might be worth considering writing a function to selectively match to appropriate raster
test_rasters_merged <- do.call(raster::merge, test_rasters)
