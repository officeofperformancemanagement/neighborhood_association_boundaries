#!/bin/sh -e

curl "https://www.google.com/maps/d/kml?mid=1wWZZ8zxo50QUP9_VKePCquh9D_FWk-w&forcekml=1" > temp.kml

ogr2ogr -dim XY -f CSV -lco GEOMETRY=AS_WKT -lco GEOMETRY_NAME=boundary -nlt MULTIPOLYGON -sql "SELECT Name AS name,description AS description FROM \"Neighborhood Association Boundaries\" WHERE OGR_GEOMETRY='MultiPolygon' or OGR_GEOMETRY='Polygon'" -skipfailures ./files/neighborhood_association_boundaries.csv temp.kml

ogr2ogr -dim XY -nlt MULTIPOLYGON -select "Name,description" -clipsrclayer "Neighborhood Association Boundaries" -where "OGR_GEOMETRY='MultiPolygon' or OGR_GEOMETRY='Polygon'" -skipfailures ./files/neighborhood_association_boundaries.geojson temp.kml

rm temp.kml
