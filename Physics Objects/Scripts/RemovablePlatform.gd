tool
extends Platform
class_name RemovablePlatform

onready var texture : TextureRect = $TextureRect
onready var removalParticles : Particles2D = $Particles2D

var is_mouse_hovering : bool 

# Called when the node enters the scene tree for the first time.
func _ready():
	texture.modulate = Color(0.8, 0.8, 0.8, 1)
	connect("mouse_entered", self, "on_mouse_entered")
	connect("mouse_exited", self, "on_mouse_exited")
	

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_mouse_hovering and Input.is_mouse_button_pressed(BUTTON_LEFT):
		remove()

func on_mouse_entered():

	texture.modulate = Color(1, 1, 1, 1)
	is_mouse_hovering = true

func on_mouse_exited():
	texture.modulate = Color(0.8, 0.8, 0.8, 1)
	is_mouse_hovering = false

func remove():
	removalParticles.emitting = true
	texture.visible = false
	$CollisionShape2D.disabled = true
	yield (get_tree().create_timer(2),"timeout")
	
	queue_free()
