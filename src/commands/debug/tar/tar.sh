#include "extract.sh"
#include "ls.sh"

@l _ debug:tar debug_tar Write tar to stdout
function debug_tar {
  cat $embed_tar
}

