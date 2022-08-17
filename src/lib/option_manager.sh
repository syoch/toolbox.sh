declare -A option_types
declare -A option_names
declare -A option_patterns
declare -A option_descriptions
declare -A option_defaults
declare -A options
declare -A args

function @c {
  local type=$1
  local name=$2
  local pattern=$3
  local description=$4
  local default=$5

  option_types["$name"]="$type"
  option_names["$name"]="$name"
  option_patterns["$name"]="$pattern"
  option_descriptions["$name"]="$description"
  option_defaults["$name"]="$default"

  options["$name"]="$default"
}



function parse_args {
  declare -A args
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
      args+="$1"
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
  remaining_args=("${args[@]}")
}

function debug_config {
  logging_group verbose "Configurations"
  for key in "${!options[@]}"; do
    logging info "$key: ${options[$key]}"
  done
  logging_group_end
}