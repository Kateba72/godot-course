extends Control

onready var button_container : GridContainer = $LevelButtons

# Called when the node enters the scene tree for the first time.
func _ready():
    generate_level_buttons()

func generate_level_buttons():
    for i in range(GameManager.levels.size()):
        var this_level_count = GameManager.levels[i].size()
        for j in this_level_count:
            var button :  Button = Button.new()
            button.rect_min_size = Vector2(100,50)
            button.connect("pressed", GameManager, "load_level", [i, j])
            button.text = GameManager.levels[i][j][1]
            button_container.add_child(button)
            button.connect("pressed", GameManager, "unload_menu")
        var buttons_in_line =  this_level_count % button_container.columns
        if buttons_in_line != 0:
            for j in button_container.columns - buttons_in_line:
                button_container.add_child(Label.new())
            