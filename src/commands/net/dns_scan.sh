@l _ net:dns_scan net_dns_scan Scans all hosts which can resolve by specified dns server.
function net_ {
  local readonly DNS=$1
  function check_host {
    nslookup $1 $DNS | grep "name ="
  }

  for j in `seq 0 255`; do
    for i in `seq 0 255`; do
      check_host 172.16.$j.$i &
      sleep 0.01
    done
    sleep 0.01
  done

  wait
}