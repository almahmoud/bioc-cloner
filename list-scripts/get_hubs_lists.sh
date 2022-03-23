curl -o list-scripts/annotationhub.sqlite3 https://annotationhub.bioconductor.org/metadata/annotationhub.sqlite3

sqlite3 -csv list-scripts/annotationhub.sqlite3 "select rdatapath from rdatapaths where id in (Select id from resources where location_prefix_id = 1)" > list-scripts/annotationhub.csv

curl -o list-scripts/experimenthub.sqlite3 https://experimenthub.bioconductor.org/metadata/experimenthub.sqlite3

sqlite3 -csv list-scripts/experimenthub.sqlite3 "select rdatapath from rdatapaths where id in (Select id from resources where location_prefix_id = 2)" > list-scripts/experimenthub.csv