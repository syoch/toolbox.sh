#include "_config.sh"
#include "logging.sh"
#include "utils.sh"

#include "command_loader.sh"
#include "meta_opt_parser.sh"
#include "opt_parser.sh"
#include "embed_file.sh"

#include "commands/commands.sh"

function main {
  local subcommand=$1
  shift

  load_options

  parse_args $@

  if [ -z "$subcommand" ]; then
    subcommand="help"
  fi

  exec_command $subcommand $@
}

main $@