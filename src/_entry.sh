#include "lib/lib.sh"
#include "_config.sh"
#include "commands/commands.sh"


function main {
  parse_args $*
  tar_init $0
  load_tar_commands

  local subcommand=${remaining_args[0]}
  if [ -z "$subcommand" ]; then
    subcommand="help"
  else
    shift
  fi

  if [ -z "$subcommand" ]; then
    subcommand="help"
  fi

  exec_command $subcommand $@
}

main $@