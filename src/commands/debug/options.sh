@l _ debug:options debug_options Show all loaded options
function debug_options {
  logging_group info "Options"
  for option in "${!options[@]}"; do
    echo $option
  done
  logging_group_end
}