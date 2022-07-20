@l _ debug:tar:ls debug_tar_ls List files in tar
function debug_tar_ls {
  logging_group info "Tar contents"
  for name in $(tar ztf $embed_tar); do
    logging info "$name"
  done
  logging_group_end
}