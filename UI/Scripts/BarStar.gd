extends TextureRect

var collected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collected(0)

func set_collected(value: int):
	collected = value
	if value == 1:
		$HalfStar.visible = true


func collect():
	set_collected(2)
	$AnimationPlayer.play("collect")