embed_file_line=`awk '/^__EMBED_FILE__/ {print NR+1}' $0`

function embed_file {
  tail -n +$embed_file_line $0 | base64 -d
}