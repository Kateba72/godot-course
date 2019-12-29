extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func go_to_sleep():
	can_sleep=true
	set_sleeping(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > get_viewport().size.y:
		GameManager.reset_level()
