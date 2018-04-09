content=$(curl -s ipinfo.io/)
ip=$(echo $content | jq -r .ip)
city=$(echo $content | jq -r .city)
country=$(echo $content | jq -r .country)
echo "$ip - $city ($country)"
