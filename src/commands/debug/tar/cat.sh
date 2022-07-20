@l _ debug:tar:cat debug_tar_cat cat file in tar
function debug_tar_cat {
  local readonly file=$1

  tar zxf $embed_tar $file -O | cat
}