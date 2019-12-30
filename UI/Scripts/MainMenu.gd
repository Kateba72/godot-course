extends Control

onready var button_container : GridContainer = $LevelButtons
var reset_dialog_scene = preload("res://UI/Scenes/ResetDialog.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_level_buttons()
	$ResetButton.connect("pressed", self, "show_reset_dialog")

func generate_level_buttons():
	for i in range(GameManager.levels.size()):
		var button :  Button = Button.new()
		button.rect_min_size = Vector2(100,50)
		button.connect("pressed", GameManager, "load_level", [i])
		button.text = "Level " + str(i+1)
		button_container.add_child(button)
		button.connect("pressed", GameManager, "unload_menu")
		if i > GameManager.last_completed_level_index + 1:
			button.disabled = true

func show_reset_dialog():
	GameManager.load_scene(reset_dialog_scene)