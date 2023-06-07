#Title:Blackjack-Python
#Author:@RokCK
#Version:0.1.2

import random

#Funciones
def draw_card():
    suits = ["Treboles", "Diamantes", "Corazones", "Espadas"]
    ranks = ["2", "2", "2", "2", "3", "3", "3", "3", "4", "4", "4", "4", "5", "5", "5", "5", "6", "6", "6", "6", "7", "7", "7", "7", "8", "8", "8", "8", "9", "9", "9", "9", "10", "10", "10", "10", "Jota", "Jota", "Jota", "Jota", "Reina", "Reina", "Reina", "Reina", "Rey", "Rey", "Rey", "Rey", "Rey", "As", "As", "As", "As"]
    return f"{random.choice(ranks)} of {random.choice(suits)}"

def card_value(card):
    rank = card.split()[0]
    if rank in ["Jota", "Reina", "Rey"]:
        return 10
    elif rank == "As":
        return 11
    else:
        return int(rank)

def hand_value(hand):
    value = sum(card_value(card) for card in hand)
    if value > 21 and "As" in [card.split()[0] for card in hand]:
        value -= 10
    return value

print("..:: BLACKJACK ::..")
hand = [draw_card(), draw_card()]
print(f"Tu mano: {hand[0]}, {hand[1]}")
hand_value = hand_value(hand)

if hand_value == 21:
    print("Felicidades. Ganaste!")
    quit()

while True:
    action = input("Decide: pides o te quedas? ").lower()

    if action == "p":
        hand.append(draw_card())
        print(f"Sacaste: {hand[-1]}")
        hand_value = hand_value(hand)

        if hand_value > 21:
            print("Te pasaste. Has perdido.")
            quit()
        elif hand_value == 21:
            print("Tu mano vale 21! Felicidades. Ganaste.")
            quit()
        else:
            print(f"Tu mano vale: {hand_value}")
    elif action == "q":
        print("Te quedas con una mano de {hand_value}.")
        break
    else:
        print("Opcion inexistente. Escribe 'p' o 'q'.")
