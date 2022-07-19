#!/bin/bash

function toolbox_sh {
  echo "#!/bin/bash"
  cpp src/_entry.sh
  echo "exit 0"
  echo "__EMBED_FILE__"
  cd bin
  tar czf - * | base64
  cd ..
}

function build {
  toolbox_sh > work/toolbox.sh
  chmod +x work/toolbox.sh
}

function run_test {
  f=`mktemp`
  toolbox_sh > $f
  chmod +x $f
  $f $*
  rm $f
}

function setup {
  [[ -d work ]] || mkdir work
  sudo mount -t tmpfs -o size=1G /dev/shm work
}

function main {
  me=$0
  subcommand=$1; shift
  case $subcommand in
    build) build $* ;;
    setup) setup $* ;;
    test) run_test $* ;;
    *)
      echo "Usage: $me [build|setup|test] args..."
      exit 1
      ;;
  esac
}

main $@