@l _ net:WUlog_serve net_WUlog_serve Launch built-in WiiU log reader
function net_WUlog_serve {
  socat -u UDP-LISTEN:4405,fork STDOUT
}