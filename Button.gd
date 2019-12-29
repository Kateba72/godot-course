extends Button

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "on_button_press")
	pass # Replace with function body.

func on_button_press():
	GameManager.reset_level()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
