extends Control

onready var button_container : GridContainer = $LevelButtons
var reset_dialog_scene = preload("res://UI/Scenes/ResetDialog.tscn")
var level_button_scene = preload("res://UI/Scenes/LevelButton.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$ResetButton.connect("pressed", self, "show_reset_dialog")

func generate_level_buttons():
	var star_count = 0
	for i in range(GameManager.levels.size()):
		var button = level_button_scene.instance()
		star_count += button.set_level(i)
		$LevelButtons.add_child(button)
	
	$StarCount/Label.text = str(star_count)

func show_reset_dialog():
	GameManager.load_scene(reset_dialog_scene)