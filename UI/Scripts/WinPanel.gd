extends CanvasLayer

onready var next_button = $"Panel/HBoxContainer/Next Button"
onready var retry_button = $"Panel/HBoxContainer/Retry Button"
onready var game_end_label = $Panel/GameEndLabel
onready var animation_player = $AnimationPlayer
onready var menu_button = $"Panel/HBoxContainer/MainMenu Button"

# Called when the node enters the scene tree for the first time.
func _ready():
	on_entered_tree()
	connect("tree_entered", self, "on_entered_tree")
	if GameManager.running_game:
		next_button.connect("pressed", GameManager, "load_next_level")
		retry_button.connect("pressed", GameManager, "reset_level")
		menu_button.connect("pressed", GameManager, "unload_current_level")
		menu_button.connect("pressed", GameManager, "load_menu")

func on_entered_tree():
	if GameManager.current_level_index == GameManager.num_levels -1:
		next_button.visible = false
		next_button.disabled = true
		game_end_label.visible = true
	else:
		next_button.visible = true
		next_button.disabled = false
		game_end_label.visible = false
