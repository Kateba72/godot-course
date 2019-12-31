extends Control

func set_level(index: int):
	var name = GameManager.levels[index]
	var count = 0
	$Button.connect("pressed", GameManager, "load_level", [index])
	$Button.connect("pressed", GameManager, "unload_menu")
	$Button.text = "Level " + str(index+1)
	for i in range(1, 4):
		var collected = GameManager.progress[name]['star'+ str(i)]
		if collected:
			get_node("Star" + str(i)).set_collected(2)
			count += 1
	
	if index > GameManager.last_completed_level_index + 1:
			$Button.disabled = true
	
	return count
	