extends Control

onready var button_container : GridContainer = $LevelButtons
onready var quit_button : Button = $QuitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_level_buttons()
	quit_button.connect("pressed",self,"quit_button_press")
	
func quit_button_press():
	get_tree().quit()

func generate_level_buttons():
	for i in range(GameManager.levels.size()):
		var button :  Button = Button.new()
		button.rect_min_size = Vector2(100,50)
		button.connect("pressed", GameManager, "load_level", [i])
		button.text = "Level " + str(i)
		button_container.add_child(button)
		button.connect("pressed", GameManager, "unload_menu")