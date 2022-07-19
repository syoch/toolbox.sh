@l _ debug:tar:ls debug_tar_ls List files in tar
function debug_tar_ls {
  logging_group info "Tar contents"
  for name in $(embed_file | tar ztf -); do
    logging info "$name"
  done
  logging_group_end
}