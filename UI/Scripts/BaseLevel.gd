extends Node

export var star1: NodePath
export var star2: NodePath
export var star3: NodePath
var stars = [star1, star2, star3]
var stars_picked_up = [false, false, false]

# Called when the node enters the scene tree for the first time.
func _ready():
	var progress = GameManager.progress[GameManager.levels[GameManager.current_level_index]]
	print(progress)
	progress['star1'] = true
	if progress['star1']:
		stars_picked_up[0] = true
		# stars[0].queue_free()
		$OptionsBar.stars[0].set_collected(true)

func pick_up_star(index: int):
	$OptionsBar.pick_up_star(index)
	stars_picked_up[index] = true
	
func on_level_passed():
	GameManager.on_level_passed(stars_picked_up)