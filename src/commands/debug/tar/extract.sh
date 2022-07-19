@l _ debug:tar:extract debug_tar_extract Extract one/all files in tar
function debug_tar_extract {
  local readonly file=$1
  if [[ -z $file ]]; then
    embed_file | tar zxf -
  else
    embed_file | tar zxf - $file
  fi
}