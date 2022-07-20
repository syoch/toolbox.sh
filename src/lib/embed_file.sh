embed_file_line=`awk '/^__EMBED_FILE__/ {print NR+1}' $0`

embed_tar=`mktemp`
trap "rm -f $embed_tar" EXIT

tail -n +$embed_file_line $0 | base64 -d > $embed_tar

. <(tar zxf $embed_tar environ -O)


function tar_commands {
  tar ztf $embed_tar | grep -r "^bin/." - | sed "s/^bin\///"
}

function tar_execute {
  local readonly name=$1; shift
  local readonly tmpfile=$(mktemp)

  trap "rm $tmpfile" EXIT

  tar zxf $embed_tar bin/$name -O > $tmpfile
  chmod +x $tmpfile
  $tmpfile $*
}