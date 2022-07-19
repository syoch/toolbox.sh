declare -A commands
declare -A command_descriptions
declare -A command_pre_args

function @l {
  local command_pre_arg=$1; shift
  local command_name=$1; shift
  local function_name=$1; shift
  local description=$*

  commands["$command_name"]="$function_name"
  command_descriptions["$command_name"]="$description"

  if [[ "$command_pre_arg" != "_" ]]; then
    command_pre_args["$command_name"]="$command_pre_arg"
  fi
}

function exec_command {
  local command_name=$1
  shift
  local command_args=$*

  local command_function=${commands["$command_name"]}

  if [[ -z $command_function ]]; then
    logging error "Command '$command_name' not found"
    logging error "Use '$command_name help' for more information"
    exit 1
  fi

  local pre_arg=${command_pre_args["$command_name"]}

  $command_function $pre_arg $command_args
}

function command_list {
  (
    for x in "${!commands[@]}"; do
      echo $x
    done |
      sort |
      tr "\n" " "
    echo
  )
}