#Title:BlackjackShell
#Author:@RokCK
#Version:0.1.1
#!/bin/bash

# Funciones
function draw_card() {
    local suits=("Treboles" "Diamantes" "Corazones" "Espadas")
    local ranks=("2" "3" "4" "5" "6" "7" "8" "9" "10" "Jota" "Reina" "Rey" "As")
    echo "${ranks[RANDOM % 13]} de ${suits[RANDOM % 4]}"
}

function card_value() {
    case "$1" in
        "As"*) echo 11 ;;
        "Rey"*) echo 10 ;;
        "Reina"*) echo 10 ;;
        "Jota"*) echo 10 ;;
        *) echo "${1%% *}" ;;
    esac
}

function hand_value() {
    local sum=0
    local aces=0

    for card in "${hand[@]}"; do
        local value=$(card_value "$card")
        sum=$((sum + value))

        if [[ $value -eq 11 ]]; then
            aces=$((aces + 1))
        fi
    done

    while [[ $sum -gt 21 && $aces -gt 0 ]]; do
        sum=$((sum - 10))
        aces=$((aces - 1))
    done

    echo $sum
}

function crupier_value() {
    local sum=0
    local aces=0

    for card in "${crupier[@]}"; do
	local value=$(card_value "$card")
	sum=$((sum + value))

	if [[ $value -eq 11 ]]; then
	    aces=$((aces + 1))
	fi
    done

    while [[ $sum -gt 21 && $aces -gt 0 ]]; do
	sum=$((sum - 10))
	aces=$((aces - 1))
    done

    echo $sum
}

# Juego
echo "..:: BLACKJACK ::.."
sleep 2
echo ""
echo -n "Iniciando"
sleep 1
echo -n "."
sleep 1
echo -n "."
sleep 1
echo -n "."
echo ""
sleep 2
hand=()
hand+=("$(draw_card)")
hand+=("$(draw_card)")

sleep 1
echo ""
echo "-----------"
echo "Tu mano: ${hand[0]}, ${hand[1]}."
hand_value=$(hand_value)
sleep 1
echo "Tu mano vale $hand_value."

if [[ $hand_value -eq 21 ]]; then
    sleep 1
    echo "Felicidades. Ganaste!"
    echo ""
    sleep 1
    echo "Juego terminado."
    echo "-----------"
    exit 0
fi

while true; do
    sleep 1
    read -p "Decide: pides o te quedas? " action

    case "$action" in
        p)
            hand+=("$(draw_card)")
            sleep 1
	    echo "Sacaste: ${hand[-1]}."
            hand_value=$(hand_value)

            if [[ $hand_value -gt 21 ]]; then
		sleep 1
                echo "Tu mano vale $hand_value. Te pasaste. Has perdido."
		echo ""
		sleep 1
		echo "Juego terminado"
		echo "-----------"
                exit 0
            elif [[ $hand_value -eq 21 ]]; then
		sleep 1
                echo "Tu mano vale 21! Felicidades. Ganaste."
		echo ""
		sleep 1
		echo "Juego terminado."
		echo "-----------"
                exit 0
            else
		sleep 1
                echo "Tu mano vale: $hand_value."
            fi
            ;;
        q)
	    sleep 1
            echo "Te quedas con una mano de $hand_value."
            break
            ;;
        *)
	    sleep 1
            echo "Opcion inexistente. Escribe 'p' o 'q'."
            ;;
    esac
done

echo ""
sleep 2
crupier=()
crupier+=("$(draw_card)")
crupier+=("$(draw_card)")
echo "Crupier: ${crupier[0]}, ${crupier[1]}."
crupier_value=$(crupier_value)
sleep 2
echo "La mano del crupier vale $crupier_value."

if [[ $crupier_hand -eq 21 ]]; then
    sleep 2
    echo "Crupier saco 21."
    exit 0
fi

while [[ $crupier_value -lt 17 ]]; do
        sleep 3
	crupier+=("$(draw_card)")
	echo "Crupier saco: ${crupier[-1]}."
	crupier_value=$(crupier_value)

	if [[ $crupier_value -gt 21 ]]; then
	    sleep 2
	    echo "La mano del crupier vale $crupier_value. Se paso. Ganaste."
	    echo ""
	    sleep 1
	    echo "Juego terminado."
	    echo "-----------"
	    exit 0
        elif [[ $crupier_value -eq 21 ]]; then
	    sleep 2
	    echo "Crupier saco 21."
	else
	    sleep 2
	    echo "La mano del crupier vale: $crupier_value."
	fi
done

echo ""
sleep 2
if [[ $hand_value -gt $crupier_value ]]; then
    echo "$hand_value vence a $crupier_value. Felicidades. Ganaste."
elif [[ $hand_value -lt $crupier_value ]]; then
    echo "$crupier_value vence a $hand_value. Lo siento. Has perdido."
else
    echo "Ambas manos tienen un valor de $hand_value. Es un empate."
fi
echo ""
sleep 1
echo "Juego terminado"
echo "-----------"
