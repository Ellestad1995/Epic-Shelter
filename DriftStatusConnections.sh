
#Curler nettsiden med brukernavn:passrod | bytter ut , med space | henter line | printer ut riktig tall 
CONNECTIONS=$(curl "http://10.212.136.88:6969/;csv/" -u akvillo:MacbookLenovo | tr "," " " | grep "akvillo FRONTEND" | awk '{print $3}')

#antall sekunder siden unix tiden
HUGEDATE=$(date +%s)

#Skriver til fil
echo "$HUGEDATE,$CONNECTIONS" >> webrate_date.csv
