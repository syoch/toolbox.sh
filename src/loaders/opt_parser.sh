declare -A options
declare -A args

function parse_args {
  while (( $# > 0 )); do
    option_name=""
    for opt_name in "${option_names[@]}"; do
      IFS=',' read -ra opt_pattern <<< "${option_patterns[$opt_name]}"
      for opt_pattern in "${opt_pattern[@]}"; do
        if [[ $1 =~ $opt_pattern ]]; then
          option_name=$opt_name
          break
        fi
      done
    done

    if [[ -z $option_name ]]; then
      args+=("$1")
      shift
    elif [[ ${option_types[$option_name]} == pair ]]; then
      options[$option_name]=$2
      shift 2
    else
      echo "Unknown option type: ${option_types[$option_name]}"
      echo "Option name: $option_name"
      exit 1
    fi

  done
}

function debug_config {
  logging_group verbose "Configurations"
  for key in "${!options[@]}"; do
    logging info "$key: ${options[$key]}"
  done
  logging_group_end

}