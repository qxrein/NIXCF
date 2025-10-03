package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"time"
)

const (
	configFile      = "/tmp/i3status-water-plugin.json"
	totalDailyWater = 3700 // in ml (3.7 liters recommended for men)
	updateInterval  = 5 * time.Minute
)

type WaterState struct {
	LastDrink    time.Time `json:"last_drink"`
	CurrentLevel int       `json:"current_level"` // in ml
}

func main() {
	if len(os.Args) > 1 && os.Args[1] == "click" {
		handleClick()
		return
	}

	state := loadState()
	updateWaterLevel(&state)
	saveState(state)

	output := map[string]interface{}{
		"full_text":   fmt.Sprintf("💧 %d%%", calculatePercentage(state.CurrentLevel)),
		"color":       getColor(state.CurrentLevel),
		"name":        "water",
		"instance":    "water",
		"urgent":      state.CurrentLevel < (totalDailyWater/10),
		"separator":   true,
		"separator_block_width": 30,
	}

	json.NewEncoder(os.Stdout).Encode(output)
}

func handleClick() {
	state := loadState()
	state.LastDrink = time.Now()
	state.CurrentLevel = totalDailyWater
	saveState(state)
}

func loadState() WaterState {
	var state WaterState

	data, err := ioutil.ReadFile(configFile)
	if err != nil {
		// Initialize new state if file doesn't exist
		return WaterState{
			LastDrink:    time.Now(),
			CurrentLevel: totalDailyWater,
		}
	}

	json.Unmarshal(data, &state)
	return state
}

func saveState(state WaterState) {
	data, _ := json.Marshal(state)
	ioutil.WriteFile(configFile, data, 0644)
}

func updateWaterLevel(state *WaterState) {
	now := time.Now()
	elapsed := now.Sub(state.LastDrink)

	// Calculate water consumption (assuming linear consumption over 16 waking hours)
	consumptionRate := float64(totalDailyWater) / (16 * 60 * 60) // ml per second
	consumed := int(consumptionRate * elapsed.Seconds())

	state.CurrentLevel -= consumed
	if state.CurrentLevel < 0 {
		state.CurrentLevel = 0
	}

	// Reset if it's a new day
	if now.Day() != state.LastDrink.Day() {
		state.LastDrink = now
		state.CurrentLevel = totalDailyWater
	}
}

func calculatePercentage(ml int) int {
	percentage := (ml * 100) / totalDailyWater
	if percentage < 0 {
		return 0
	}
	if percentage > 100 {
		return 100
	}
	return percentage
}

func getColor(ml int) string {
	percentage := calculatePercentage(ml)
	switch {
	case percentage < 20:
		return "#FF0000" // Red
	case percentage < 50:
		return "#FFA500" // Orange
	default:
		return "#00FF00" // Green
	}
}
