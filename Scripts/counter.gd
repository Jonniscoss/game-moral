extends Label

func update_counter():
	$ScrollCounter.text = str(DropManager.collected) + "/" + str(DropManager.total)
