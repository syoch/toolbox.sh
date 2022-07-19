declare -A option_types
declare -A option_names
declare -A option_patterns
declare -A option_descriptions
declare -A option_defaults

function load_options {
  while read line; do
    IFS='|' read -ra ARR <<< "$line"

    local type=`echo ${ARR[0]} | sed -r 's/^\s*(.*)\s*/\1/'`
    local name=`echo ${ARR[1]} | sed -r 's/^\s*(.*)\s*/\1/'`
    local pattern=`echo ${ARR[2]} | sed -r 's/^\s*(.*)\s*/\1/'`
    local description=`echo ${ARR[3]} | sed -r 's/^\s*(.*)\s*/\1/'`
    local default=`echo ${ARR[4]} | sed -r 's/^\s*(.*)\s*/\1/'`

    option_types["$name"]="$type"
    option_names["$name"]="$name"
    option_patterns["$name"]="$pattern"
    option_descriptions["$name"]="$description"
    option_defaults["$name"]="$default"

    options["$name"]="$default"

  done < <(grep -r "^: #- " $0 | sed -r 's/^: #- (.*)$/\1/')
}