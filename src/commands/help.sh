@l _ help _help Prints help message.
function _help {
  echo "Usage: $0 [command] [options] [args]"
  echo "Options:"
  for key in "${option_names[@]}"; do
    if [[ ${option_types[$key]} == pair ]]; then
      echo "  ${option_patterns["$key"]} <$key>: ${option_descriptions[$key]}"
    else
      logging error "Unknown option type: ${option_types[$key]}"
      exit 1
    fi
  done
  echo "Commands:"

  for command in `command_list`; do
    echo "  $command; ${command_descriptions["$command"]}"
  done
}