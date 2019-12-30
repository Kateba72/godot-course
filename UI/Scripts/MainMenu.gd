extends Control

onready var vbox = $VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
    generate_level_buttons()
    
var padding: int = 100
var spacing: int = 20
var height: int = 100

var stage_names = [
    "Tutorial:",
    "First Game:",
]

func generate_level_buttons():
    var line = 0
    var column = 0
    for i in range(GameManager.levels.size()):
        var stage_container = HBoxContainer.new()
        vbox.add_child(stage_container)
        if i < stage_names.size():
            var label = Label.new()
            label.text = stage_names[i]
            stage_container.add_child(label)
        var this_level_count = GameManager.levels[i].size()
        for j in this_level_count:
            var button :  Button = Button.new()
            button.rect_min_size = Vector2(100,50)
            button.connect("pressed", GameManager, "load_level", [i, j])
            button.text = GameManager.levels[i][j][1]
            stage_container.add_child(button)
            button.connect("pressed", GameManager, "unload_menu")
            