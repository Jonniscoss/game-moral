extends CanvasLayer

@onready var counter_label := $ScrollCounter

func _ready():
	update_counter()

func update_counter():
	counter_label.text = str(DropManager.collected) + "/" + str(DropManager.total)
