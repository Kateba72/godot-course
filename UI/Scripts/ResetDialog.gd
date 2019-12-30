extends CanvasLayer

onready var yes_button = $"Panel/Yes"
onready var no_button = $"Panel/No"

# Called when the node enters the scene tree for the first time.
func _ready():
	yes_button.connect("pressed", self, "yes_button_pressed")
	no_button.connect("pressed", self, "no_button_pressed")

func yes_button_pressed():
	GameManager.reset_progress()
	GameManager.unload_menu()
	GameManager.load_menu()
	self.queue_free()

func no_button_pressed():
	self.queue_free()