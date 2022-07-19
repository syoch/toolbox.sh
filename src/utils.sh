function request {
  local url=$1; shift

  logging verbose "Requesting $url"

  curl -k "$url"
    -H "User-Agent: ${options["user_agent"]}"
    --compressed
    $@
}

function print_map {
  local -n map=$1

  logging_group info "Map [$1]"
    for key in "${!map[@]}"; do
      logging info "$key: ${map[$key]}"
    done
  logging_group_end
}