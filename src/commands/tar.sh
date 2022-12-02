function load_tar_commands {
  for name in $(tar_commands); do
    @l $name tar:$name tar_execute Execute $name from tar archive
  done
}
@l _ tar:cat tar_cat cat file in tar
function tar_cat {
  local readonly file=$1

  tar zxf $embed_tar $file -O | cat
}

@l _ tar:ls tar_ls List files in tar
function tar_ls {
  logging_group info "Tar contents"
  for name in $(tar ztf $embed_tar); do
    logging info "$name"
  done
  logging_group_end
}

@l _ tar:extract tar_extract Extract one/all files in tar
function tar_extract {
  local readonly file=$1
  if [[ -z $file ]]; then
    tar zxf $embed_tar -O
  else
    tar zxf $embed_tar $file -O
  fi
}