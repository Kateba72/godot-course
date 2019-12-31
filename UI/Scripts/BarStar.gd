extends TextureRect

var collected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collected(false)

func set_collected(b: bool):
	collected = b
	$FullStar.visible = collected
		

func collect():
	if not collected:
		$AnimationPlayer.play("collect")