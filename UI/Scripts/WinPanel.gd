extends CanvasLayer

onready var next_button = $"Panel/HBoxContainer/Next Button"
onready var animation_player = $AnimationPlayer
onready var menu_button = $"Panel/HBoxContainer/Menu Button"

# Called when the node enters the scene tree for the first time.
func _ready():
    on_entered_tree()
    connect("tree_entered", self, "on_entered_tree")
    animation_player.play("Spin")
    if GameManager.running_game:
        next_button.connect("pressed", GameManager, "load_next_level")
        menu_button.connect("pressed", GameManager, "unload_current_level")
        menu_button.connect("pressed", GameManager, "load_menu")


func on_entered_tree():
    if GameManager.has_next_level():
        next_button.visible = true
        next_button.disabled = false
    else:
        next_button.visible = false
        next_button.disabled = true