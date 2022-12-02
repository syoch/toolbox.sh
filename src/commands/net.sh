#include "./ftp.sh"


@l _ net:WUlog_serve net_WUlog_serve Launch built-in WiiU log reader
function net_WUlog_serve {
  tar_execute socat -u UDP-LISTEN:4405,fork STDOUT
}

@l _ net:dns_scan net_dns_scan Scans all hosts which can resolve by specified dns server.
function net_dns_scan {
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