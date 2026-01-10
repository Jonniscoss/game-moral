extends Node

var drop_texts := [
	"LOOT",
	"SCROLL",
	"PAPER",
	"SOMETHING",
	"MAP",
	"KEY",
	"DIARY"
]

var remaining_drops := []
var total := 0
var collected := 0

func _ready():
	remaining_drops = drop_texts.duplicate()
	total = drop_texts.size()
	collected = 0

func get_drop_text() -> String:
	if remaining_drops.size() == 0:
		return "null"
	var index = randi() % remaining_drops.size()
	var chosen_text = remaining_drops[index]
	remaining_drops.remove_at(index)
	return chosen_text

# Call this **when a scroll is picked up**
func mark_collected():
	collected += 1

# Check if all scrolls have been collected
func is_last_drop() -> bool:
	return collected >= total
