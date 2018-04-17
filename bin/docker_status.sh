if [[ $( ps -ef | grep "[d]ockerd") == "" ]]; then
  echo "x"
else
  N_IMAGES=$(docker ps | grep -vc IMAGE)
  echo "$N_IMAGES"
fi
