extends Control

onready var next_button = $"Panel/OptionPanel/NextButton"
onready var game_end_label = $"Panel/GameEndLabel"
onready var animation_player = $AnimationPlayer
onready var star_count = $"Panel/StarCountPanel"
#onready var menu_button = $"Panel/HBoxContainer/Menu Button"

# Called when the node enters the scene tree for the first time.
func _ready():
	on_entered_tree()
	$Particles2D.emitting = true
	connect("tree_entered", self, "on_entered_tree")
	star_count.playAnimation()
	star_count.set_star_count(GameManager.current_star_count)
	animation_player.play("Animation1")
	if GameManager.running_game:
		next_button.connect("pressed", GameManager, "load_next_level")


func on_entered_tree():
	if GameManager.current_level_index == GameManager.num_levels -1:
		next_button.visible = false
		next_button.disabled = true
		game_end_label.visible = true
	else:
		next_button.visible = true
		next_button.disabled = false
		game_end_label.visible = false