logging_indent=0

function logging {
  case $1 in
    verbose) echo -n "[*] ";;
    info) echo -n "[ ] ";;
    warning) echo -n "[!] ";;
    error) echo -n "<!> ";;
  esac
  printf "%${logging_indent}s"
  shift
  echo $*
}

function logging_group {
  logging $*
  logging_indent=$((logging_indent+2))
}

function logging_group_end {
  logging_indent=$((logging_indent-2))
}
