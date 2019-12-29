tool
extends Platform
class_name RemovablePlatform

onready var texture : TextureRect = $TextureRect

var is_mouse_hovering : bool 

# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	texture.modulate = Color(0.6, 0.8, 0.6, 1)
	connect("mouse_entered", self, "on_mouse_entered")
	connect("mouse_exited", self, "on_mouse_exited")
	connect("input_event", self, "on_input_event")

func on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and is_mouse_hovering:
			remove()

func on_mouse_entered():
	texture.modulate = Color(.8, 1, .8, 1)
	is_mouse_hovering = true

func on_mouse_exited():
	texture.modulate = Color(0.6, 0.8, 0.6, 1)
	is_mouse_hovering = false

func remove():
	queue_free()
