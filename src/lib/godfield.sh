gf_api_root="https://asia-northeast1-godfield.cloudfunctions.net"


gf_user_name=""
gf_room_id=""
gf_team=-1

get_room_id() {
  curl "$api_root/createRoom" -H "authorization: Bearer $authorization" \
    -d "{\"mode\":\"hidden\",\"password\":\"$1\",\"userName\":\"$user_name\"}" \
  | jq -r ".roomId"
}

join_room() {
  room_id=`get_room_id $1`

  curl -X POST "$api_root/addRoomUser" -H "authorization: Bearer $authorization" \
    -d "{\"mode\":\"hidden\",\"roomId\":\"$room_id\",\"userName\":\"$user_name\"}"

  echo "[+] Joined to room \"$1\" id: $room_id"
}

join_team() {
  team=$1
  curl "$api_root/setEntryUser" -H "authorization: Bearer $authorization" \
    --data-raw "{\"mode\":\"hidden\",\"roomId\":\"$room_id\",\"team\":$team}"
  echo "[+] Joined to team<$1>"
}

send_comment() {
  echo "[+] [Chat] $room_id: me: $1"
  curl "$api_root/setComment" -H "authorization: Bearer $authorization" \
    --data-raw "{\"mode\":\"hidden\",\"roomId\":\"$room_id\",\"text\":\"$1\"}"
}

get_new_token() {
  # $1: refresh_token
  curl 'https://securetoken.googleapis.com/v1/token?key=AIzaSyCBvMvZkHymK04BfEaERtbmELhyL8-mtAg' \
    --data-raw "grant_type=refresh_token&refresh_token=$1" \
    --compressed | jq -r ".access_token"
}

renew_token() {
  authorization=`get_new_token $refresh_token`
  echo "[!] New Authorization token: $authorization"
}

set_tie_breaker() {
  echo "[*] Set tiebreaker to $1 at $room_id"
  curl "$api_root/setTiebreaker" -H "authorization: Bearer $authorization" \
    --data-raw "{\"mode\":\"hidden\",\"roomId\":\"$room_id\",\"turnCount\":$1}"
}

start_game() {
  echo "[ ] Start the game..."
  curl "$api_root/addGame" -H "authorization: Bearer $authorization" \
    --data-raw "{\"mode\":\"hidden\",\"roomId\":\"$room_id\"}"
}

leave_room() {
  echo "[ ] Leaving the room..."
  curl "$api_root/removeRoomUser" -H "authorization: Bearer $authorization" \
    --data-raw "{\"mode\":\"hidden\",\"roomId\":\"$room_id\"}"
}

: <<EOF
command
  Use Item
    itemIds: [3]
    targetPlayerId: 1 (For Attack to player)
    mp: ?, cp: ? (両替)
EOF

update_game() {
  echo "[*] Applying command: $1"
  curl "$api_root/updateGame" -H "authorization: Bearer $authorization" \
    --data-raw "{\"mode\":\"hidden\",\"roomId\":\"$room_id\",\"command\":$1}"
}

# user_name="ねこだよ"
# # renew_token
# join_room "syochsyoch"
# join_team 0
# set_tie_breaker 150
# send_comment "Godfield Shellscript framework has started!"