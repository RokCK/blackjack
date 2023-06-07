//Title:Blackjack-Go
//Author:@RokCK
//Version:0.1.2

package main
import (
  "fmt"
  "math/rand"
  "time"
)

func DrawCard() string {
	suits := []string{"Treboles", "Diamantes", "Corazones", "Espadas"}
	ranks := []string{"2", "2", "2", "2", "3", "3", "3", "3", "4", "4", "4", "4", "5", "5", "5", "5", "6", "6", "6", "6", "7", "7", "7", "7", "8", "8", "8", "8", "9", "9", "9", "9", "10", "10", "10", "10", "Jota", "Jota", "Jota", "Jota", "Reina", "Reina", "Reina", "Reina", "Rey", "Rey", "Rey", "Rey", "As", "As", "As", "As"}
	rand.Seed(time.Now().UnixNano())
	suit := suits[rand.Intn(len(suits))]
	rank := ranks[rand.Intn(len(ranks))]
	return fmt.Sprintf("%s de %s", rank, suit)
}

func CardValue(card string) int {
	switch {
	case strings.HasPrefix(card, "As"):
		return 11
	case strings.HasPrefix(card, "Jota"),
		strings.HasPrefix(card, "Reina"),
		strings.HasPrefix(card, "Rey"):
		return 10
	default:
		return convertRankToValue(card)
	}
}

func convertRankToValue(card string) int {
	cardParts := strings.Split(card, " ")
	rank := cardParts[0]
	switch rank {
	case "2", "3", "4", "5", "6", "7", "8", "9", "10":
		value, _ := strconv.Atoi(rank)
		return value
	default:
		return 0
	}
}

func HandValue(hand []string) int {
	sum := 0
	aces := 0
	for _, card := range hand {
		value := CardValue(card)
		sum += value
		if value == 11 {
			aces++
		}
	}
	for sum > 21 && aces > 0 {
		sum -= 10
		aces--
	}
	return sum
}

func main() {
  fmt.Println("Hola Mundo")
}
