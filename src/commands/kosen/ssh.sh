@l _ kosen:ssh kosen_ssh Login to Kosen SSH Server
function kosen_ssh {
  ssh $KOSEN_SERVER -l $KOSEN_USER $*
}