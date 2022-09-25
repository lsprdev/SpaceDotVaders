#!/bin/bash

tput civis #Faz o cursor ficar invisivel
clear #Limpa a tela

FARRIGHT=50 #Máximo que a nave pode ir(tamanho da tela jogável)

# Movimentação da nave
ship=25 # Posição inicial da nave(x)
bottom=20 # Posição inicial da nave(y)

function drawship
{
    clear
    tput cup $bottom 0
    printf "%80s" " "
    tput cup $bottom $ship
    shipStyle=("|--|\033[1;31m*\033[0m|--|")
    echo -en "$shipStyle"
}

drawship

# Looping principal
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
        w) # Move pra cima
            [ $bottom -gt 0 ] && ((bottom=bottom-1))
                drawship
            ;;
        s) # Move pra baixo
            [ $bottom -lt 20 ] && ((bottom=bottom+1))
                drawship
            ;;
        q)
	        echo -e "\nEspero vê-lo de novo!" && tput cnorm && exit 0
	        ;;
  esac
done