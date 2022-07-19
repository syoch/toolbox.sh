@l _ net:ftp:put net_ftp_put Upload a file to FTP Server
function net_ftp_put {
  local path=$1; shift
  local file=$1; shift

  logging verbose "Uploading $file to ${options["host"]}:${options["port"]}/$path"

  exec 3<> /dev/tcp/${options["host"]}/${options["port"]}

  read -u 3 line # ready

  printf "USER ${options["user"]}\r\n" >&3; read -u 3 line # Username ok
  printf "PASS ${options["pass"]}\r\n" >&3; read -u 3 line # login successful.
  printf "PASV\r\n" >&3; read -u 3 line

  local pasv_ip=$(echo $line | sed -r 's/.*\(([0-9]+),([0-9]+),([0-9]+),([0-9]+),.*/\1.\2.\3.\4/')
  local pasv_port=$(echo $line | sed -r 's/.*,([0-9]+),([0-9]+)\).*/\1 \2/' | awk '{print $1*256+$2}')

  printf "TYPE I\r\n" >&3; read -u 3 line # Binary mode.
  printf "CWD $path\r\n" >&3; read -u 3 line # ~~~ is the current directory.
  printf "STOR $file\r\n" >&3; read -u 3 line # File transfer starting.

  cat $file > /dev/tcp/$pasv_ip/$pasv_port

  exec 4<&-
  exec 4>&-
  exec 3<&-
  exec 3>&-
}