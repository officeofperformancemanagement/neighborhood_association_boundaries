#!/bin/sh -e

ogr2ogr -dim XY -f CSV -lco GEOMETRY=AS_WKT -lco GEOMETRY_NAME=boundary -nlt MULTIPOLYGON -sql "SELECT Name AS name,description AS description FROM \"Neighborhood Association Boundaries\" WHERE OGR_GEOMETRY='MultiPolygon' or OGR_GEOMETRY='Polygon'" -skipfailures ./files/neighborhood_association_boundaries.csv "/vsicurl/https://www.google.com/maps/d/kml?mid=1wWZZ8zxo50QUP9_VKePCquh9D_FWk-w&forcekml=1"

sleep 15

ogr2ogr -dim XY -nlt MULTIPOLYGON -select "Name,description" -clipsrclayer "Neighborhood Association Boundaries" -skipfailures ./neighborhood_association_boundaries.geojson "/vsicurl/https://www.google.com/maps/d/kml?mid=1wWZZ8zxo50QUP9_VKePCquh9D_FWk-w&forcekml=1"
