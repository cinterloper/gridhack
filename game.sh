luabash load src/gridhack.lua
if [ "$?" = "0" ]
then
  echo "USAGE: x to select, arrows to move, s and f to toggle show minefield"
else
  echo "COULD NOT LOAD gridhack.lua"
fi
getKey() {
  read -rsn1 k
}

putCursor() {
  tput cup ${X:-0} ${Y:-0}
}

main() {
  unset X Y k
  declare -i X
  declare -i Y
  clear
  l_initBoard
  RUNNING=1
  while [ "$RUNNING" = "1" ] #game loop
  do
      clear
      l_game
      putCursor
      getKey
  done
  read
  clear
}
