extends Node

onready var reset_button = $"Panel/HBoxContainer/Reset Button"
onready var menu_button = $"Panel/HBoxContainer/Menu Button"
onready var title_label = $"Panel/Title Label"

# Called when the node enters the scene tree for the first time.
func _ready():
    if GameManager.running_game:
        reset_button.connect("pressed", GameManager, "reset_level")
        menu_button.connect("pressed", GameManager, "unload_current_level")
        menu_button.connect("pressed", GameManager, "load_menu")


func _input(event):
    if event is InputEventKey and event.pressed:
        if event.scancode == KEY_R:
            GameManager.reset_level()