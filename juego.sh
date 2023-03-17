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

# Juego
echo "Blackjack de Carlos"

hand=()
hand+=("$(draw_card)")
hand+=("$(draw_card)")

echo "Tu mano: ${hand[0]}, ${hand[1]}"
hand_value=$(hand_value)

if [[ $hand_value -eq 21 ]]; then
    echo "21. Ganaste!"
    exit 0
fi

while true; do
    read -p "Decide: pides o te quedas? " action

    case "$action" in
        p)
            hand+=("$(draw_card)")
            echo "Sacaste: ${hand[-1]}"
            hand_value=$(hand_value)

            if [[ $hand_value -gt 21 ]]; then
                echo "Perdiste! Te pasaste."
                exit 0
            elif [[ $hand_value -eq 21 ]]; then
                echo "21! Ganaste!"
                exit 0
            else
                echo "Tu mano vale: $hand_value"
            fi
            ;;
        q)
            echo "Te quedas con una mano de $hand_value."
            break
            ;;
        *)
            echo "Opcion inexistente. Escribe 'p' o 'q'."
            ;;
    esac
done
