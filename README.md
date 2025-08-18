## Map visualizing variables for the Drivers Paper

gridviz_plugin_strasbourg.html is a split view map of the variables in the 3 case regions. it is a leaflet map using the gridviz plugin allowing me to store just the point data instead of square polygons.

To do before submission:
- [ ] the csv data is in crs 3035 because this is what is compatible with the gridviz plugin. however, leaflet basemaps are crs 3857. the mismatch is visible in the liverpool map. demo.html is a demo from the gridviz developers where they use proj4leaflet library to reproject the basemap but i didn't manage to implement this yet.

To do at a later point: 
- [ ] Add sources
- [ ] Make faster by loading tiles? 
- [ ] Solve white phase between layer changes?
- [ ] Add case outline
- [ ] Add prediction layer for densification probability (together with actual densification?)
- [ ] when browser window is half size, can I recenter the map?
