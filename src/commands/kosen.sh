@l _ kosen:login kosen_login Login to kosen Wi-Fi
function kosen_login {
  request 'https://1.1.1.1/login.html'
    -H "Content-Type: application/x-www-form-urlencoded"
    --data-raw "buttonClicked=4&err_flag=0&err_msg=&info_flag=0&info_msg=&redirect_url=&network_name=Guest+Network&username=$KOSEN_USER&password=$KOSEN_PASS"
}

@l _ kosen:ssh kosen_ssh Login to Kosen SSH Server
function kosen_ssh {
  ssh $KOSEN_SERVER -l $KOSEN_USER $*
}