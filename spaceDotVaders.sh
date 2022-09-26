#!/bin/bash

tput civis #Faz o cursor ficar invisivel
clear #Limpa a tela

all_lines=$(tput lines) #Pega o numero de linhas da tela
all_columns=$(tput cols) #Pega o numero de colunas da tela

# Movimentação da nave
right=100 #Máxima posição para a direita
bottom=$((all_lines-5)) # Posição inicial da nave(y)
shipx=$((right/2)) # Posição inicial da nave(x)

arenaX=$((all_columns)) #Tamanho da arena(x)
arenaY=$((all_lines))

# Cores 
DARKGRAY='\033[1;30m'
RED='\033[0;31m'    
LIGHTRED='\033[1;31m'
GREEN='\033[0;32m'    
YELLOW='\033[1;33m'
BLUE='\033[0;34m'    
PURPLE='\033[0;35m'    
LIGHTPURPLE='\033[1;35m'
CYAN='\033[0;36m'    
WHITE='\033[1;37m'
SET='\033[0m'

function move_ship {
    case "$1" in
        LEFT) shipx=$[shipx-1] ;; # Left
        RIGHT) shipx=$[shipx+1] ;; # Right
    esac
    if [ $shipx -lt 2 ]; then
        shipx=2
    fi
    if [ $shipx -gt $((arenaX-11)) ]; then
        shipx=$((arenaX-11))
    fi
}

function draw_area {
    # Desenha a área de jogo
    r=$1
    b=$2
    printf "\e[1;32m"
    local x y o="#"
    for ((x=0;x<=$r;x++))
    do
        printf  "\e[1;${x}f$o\e[$b;${x}f$o"
    done
    for ((y=0;y<=$b;y++))
    do
        printf "\e[${y};1f$o\e[${y};${r}f$o"
    done
}

function draw_ship
{
    tput cup $bottom 0
    printf "%80s" " "
    tput cup $bottom $shipx
    shipStyle=("${WHITE}|--|${RED}*${SET}|--|${SET}")
    echo -en "$shipStyle"
}

draw_ship
# Looping principal
while :
do
    draw_area $arenaX $arenaY
    read -s -n 1 key #Lê o input do teclado
    case "$key" in
        a)
            move_ship LEFT
            draw_ship
            ;;
        d)
            move_ship RIGHT
            draw_ship
        ;;
        "")
            echo "Space"
        ;;
        q)
	        echo -e "\nEspero vê-lo de novo!" && tput cnorm && exit 0
	        ;;
  esac
done
