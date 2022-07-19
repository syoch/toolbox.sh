#include "_config.sh"

#include "lib/lib.sh"
#include "loaders/loaders.sh"
#include "commands/commands.sh"

function main {
  local subcommand=$1
  shift


  if [ -z "$subcommand" ]; then
    subcommand="help"
  fi

  exec_command $subcommand $@
}

main $@