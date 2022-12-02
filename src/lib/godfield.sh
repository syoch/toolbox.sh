gf_api_root="https://asia-northeast1-godfield.cloudfunctions.net"
gf_refresh_token="AOkPPWTcnXKUTncqpepwL-JPYnaqtKQo8VvY3Ba-9sKXNTDcxKYZ9otSJ96KPL0p2YTkQopriT1YMl7OaZyVlCThl855MbrgaedyIt71AXTDCvUXu6uLDmejK4Q2L-qbmgaKVGaNPAAr_gypjnULGcZ1ymbwvCb8e7IakicVLWqN2foaaczdNZw"
gf_authorization="eyJhbGciOiJSUzI1NiIsImtpZCI6ImE5NmFkY2U5OTk5YmJmNWNkMzBmMjlmNDljZDM3ZjRjNWU2NDI3NDAiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nb2RmaWVsZCIsImF1ZCI6ImdvZGZpZWxkIiwiYXV0aF90aW1lIjoxNjYyNTU2NTQxLCJ1c2VyX2lkIjoiNkdTVUdlU3ltVGVmWm02bTZQNm9pQmlEaUYzMiIsInN1YiI6IjZHU1VHZVN5bVRlZlptNm02UDZvaUJpRGlGMzIiLCJpYXQiOjE2Njk5MDE4NDcsImV4cCI6MTY2OTkwNTQ0NywiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6e30sInNpZ25faW5fcHJvdmlkZXIiOiJhbm9ueW1vdXMifX0.iDNbMYedvgJfbA9-PrKxXOYugePJKuDSHQBq4E5AjsgY_SdqjjnK6zBtJSrjB29Fw0Bp-0RvqNWQ0mAVuXLpb9DmDwCWG2_FlBnwl7q13Nj4ZoJdh-aI5ySA8LqRwFKDloK8RbMvKe7qjAWMMyyaP87hGbwWUcUTHJmANk12Lc_rv0tZvnTVbMRwSVFsSulIj6IbIgQMTyCeQIOVlkW-As3jJQxVw9wwvU_qStbCtgQ4yDAX0_-dvf05MW9FmCLW4Zj377uhVojj0kQNyUxFkoQilJU7FIFkUrKqyQ2tjLk4l-aTv16yDe6RymP1308EcDDE3jTFzcAJnRc8nMUzUQ"

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