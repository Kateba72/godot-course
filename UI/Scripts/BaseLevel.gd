extends Node

var stars = [null, null, null]
var stars_picked_up = [0, 0, 0]

# Called when the node enters the scene tree for the first time.
func _ready():
	var progress = GameManager.progress[GameManager.current_level_name]
	for child in GameManager.current_level.get_children():
		if child is Pickable:
			stars[child.index] = child
	for i in range(3):
		if progress['star'+str(i+1)]:
			stars_picked_up[i] = 1
			stars[i].set_precollected(true)
			$OptionsBar.stars[i].set_collected(1)

func pick_up_star(index: int):
	$OptionsBar.pick_up_star(index)
	stars_picked_up[index] += 2
	
func on_level_passed():
	$"OptionsBar/Panel".visible = false
	print(stars_picked_up)
	GameManager.on_level_passed(stars_picked_up)