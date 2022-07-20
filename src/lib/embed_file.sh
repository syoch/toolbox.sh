embed_file_line=`awk '/^__EMBED_FILE__/ {print NR+1}' $0`

function embed_file {
  tail -n +$embed_file_line $0 | base64 -d
}

function tar_commands {
  embed_file | tar ztf - | grep -r "^bin/." - | sed "s/^bin\///"
}

function tar_execute {
  local readonly name=$1; shift
  local readonly tmpfile=$(mktemp)

  trap "rm $tmpfile" EXIT

  embed_file | tar zxf - bin/$name -O > $tmpfile
  chmod +x $tmpfile
  $tmpfile $*
}