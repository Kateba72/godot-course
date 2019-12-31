tool
extends Platform
class_name RemovablePlatform

onready var texture : TextureRect = $TextureRect
onready var collider = $CollisionShape2D

var is_mouse_hovering : bool 

func hover():
    if is_mouse_hovering:
        texture.modulate = Color(1, 1, 0.5, 1)
    else:
        texture.modulate = Color(0.8, 0.8, 0.4, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
    hover()
    connect("mouse_entered", self, "on_mouse_entered")
    connect("mouse_exited", self, "on_mouse_exited")

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if is_mouse_hovering and Input.is_mouse_button_pressed(BUTTON_LEFT):
        remove()

func on_mouse_entered():
    is_mouse_hovering = true
    hover()

func on_mouse_exited():
    is_mouse_hovering = false
    hover()

func remove():
    var explode = get_node("Explode")
    collider.queue_free()
    if explode != null:
        explode.emitting = true
    texture.hide()
    yield(get_tree().create_timer(0.5), "timeout")
    queue_free()
