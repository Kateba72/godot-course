extends CanvasLayer

onready var next_button = $"Panel/VBoxContainer/HBoxContainer/Next Button"
onready var menu_button = $"Panel/VBoxContainer/HBoxContainer/Menu Button"
onready var reset_button = $"Panel/VBoxContainer/HBoxContainer/Reset Button"
onready var star_box = $"Panel/VBoxContainer/Star Box"

var star_enabled = preload("res://UI/Scenes/star_enabled.tscn")
var star_disabled = preload("res://UI/Scenes/star_disabled.tscn")

func _ready():
    on_entered_tree()
    connect("tree_entered", self, "on_entered_tree")
    for index in 3:
        if index < GameManager.star_count:
            star_box.add_child(star_enabled.instance())
        else:
            star_box.add_child(star_disabled.instance())
    if GameManager.running_game:
        next_button.connect("pressed", GameManager, "load_next_level")
        menu_button.connect("pressed", GameManager, "unload_current_level")
        menu_button.connect("pressed", GameManager, "load_menu")
        reset_button.connect("pressed", GameManager, "reset_level")


func on_entered_tree():
    if GameManager.has_next_level():
        next_button.visible = true
        next_button.disabled = false
    else:
        next_button.visible = false
        next_button.disabled = true