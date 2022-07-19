#include "extract.sh"
#include "ls.sh"

@l _ debug:tar embed_file Write tar to stdout

for name in $(embed_file | tar ztf -); do
  @l $name tar:$name tar_execute Execute $name from tar archive
done

function tar_execute {
  local readonly name=$1; shift
  local readonly tmpfile=$(mktemp)

  trap "rm $tmpfile" EXIT

  embed_file | tar zxf - $name -O > $tmpfile
  chmod +x $tmpfile
  $tmpfile $*
}