#!/bin/bash

tput civis #Faz o cursor ficar invisivel
clear #Limpa a tela

FARRIGHT=50 #Máximo que a nave pode ir
ship=25 # Posição inicial da nave(x)

direction=1
offset=20
bottom=20

function drawship
{
  tput cup $bottom 0
  printf "%80s" " "
  tput cup $bottom $ship
  shipStyle=("|--|\033[1;31m*\033[0m|--|")
  echo -en "$shipStyle"
}

clear
drawship

while :
do
  read -s -n 1 key
  case "$key" in
    a)
       [ $ship -gt 0 ] && ((ship=ship-1))
	drawship
	;;
    d)
       [ $ship -lt $FARRIGHT ] && ((ship=ship+1))
	drawship
	;;
    q)
	echo "Tchau!"
	tput cvvis
	stty echo
	trap exit ALRM
	sleep $DELAY
	exit 0
	;;
  esac
done