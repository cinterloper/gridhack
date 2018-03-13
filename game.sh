luabash load src/gridhack.lua
if [ "$?" = "0" ]
then
  echo "USAGE: x to select, arrows to move, s and f to toggle show minefield"
  echo "USAGE: you can set MINE_THRESHOLD to a fraction of 1. MINE_THRESHOLD*100 == % of non-mines"
else
  echo "COULD NOT LOAD gridhack.lua"
fi
read
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
