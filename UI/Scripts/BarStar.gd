extends TextureRect

var collected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_collected(b: bool):
	collected = b
	if b:
		modulate = Color(1, 1, 1)
	else:
		modulate = Color(.33, .33, .33)
		

func collect():
	if not collected:
		$AnimationPlayer.play("collect")