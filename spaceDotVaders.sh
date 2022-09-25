#!/bin/bash

tput civis #Faz o cursor ficar invisivel
clear #Limpa a tela

FARRIGHT=$(($(tput cols) - 9)) #Máxima posição para a direita

# Movimentação da nave
ship=$(($FARRIGHT / 2)) # Posição inicial da nave(x)
bottom=$(tput lines) # Posição inicial da nave(y)


function move_ship {
    case "$1" in
        LEFT) ship=$[ship-1] ;; # Left
        RIGHT) ship=$[ship+1] ;; # Right
        UP) bottom=$[bottom-1] ;; # Up
        DOWN) bottom=$[bottom+1] ;; # Down
    esac

    if [ $ship -lt 0 ]; then
        ship=0
    fi
    if [ $ship -gt $FARRIGHT ]; then
        ship=$FARRIGHT
    fi
    if [ $bottom -lt 0 ]; then
        bottom=0
    fi
    if [ $bottom -gt 20 ]; then
        bottom=20
    fi
}

function drawship
{
    clear
    tput cup $bottom
    printf "%80s" " "
    tput cup $bottom $ship
    shipStyle=("|--|\033[1;31m*\033[0m|--|")
    echo -en "$shipStyle"
}

drawship

# Looping principal
while :
do
    read -s -n 1 key #Lê o input do teclado
    case "$key" in
        a)
            move_ship LEFT
            drawship
            ;;
        d)
            move_ship RIGHT
            drawship
            ;;
        w)
            move_ship UP
            drawship
            ;;
        s)
            move_ship DOWN
            drawship
            ;;
        q)
	        echo -e "\nEspero vê-lo de novo!" && tput cnorm && exit 0
	        ;;
  esac
done
