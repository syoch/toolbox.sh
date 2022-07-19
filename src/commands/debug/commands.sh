@l _ debug:commands debug_commands Show all loaded commands
function debug_commands {
  logging_group info "Commands"
  for command in `command_list`; do
    logging info "$command = ${commands["$command"]} :: ${command_descriptions["$command"]}"
  done
  logging_group_end
}