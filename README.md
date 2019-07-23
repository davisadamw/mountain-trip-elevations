# mountain-trip-elevations
Get start and end elevations for EV trips using mountain mode

Should basically have three steps:
1. combine multiple DEM rasters into one or two big DEMs
2. pull elevations for start, end, and farthest (maybe?) point for each trip
3. calculate delta-elevation for each trip

Script prefixes:
01_ ... testing
02_ ... merge img rasters
03_ ... process LL data, extract elevation to each point
04_ ... recombine point data and export
99_ ... functions


Limitations:
* only have start and end location for trip, might miss events where a driver activates mode to go up a hill, then doesn't turn it off until they get to the bottom?
* max distance in between or max distance on route in between points might be better...

A new line for no reason
