printStatus() {
  if [ "$1" = '
' ]; then
    echo ''
  else
    echo ' x'
  fi
}

echo "$(pgrep openvpn)"
echo "$(pgrep wg)"

printStatus "$(pgrep openvpn)"
printStatus "$(pgrep wg)"
