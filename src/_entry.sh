
#include "lib/lib.sh"
#include "commands/commands.sh"

#include "_config.sh"

function main {
  local subcommand=$1
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