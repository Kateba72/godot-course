tool
extends StaticBody2D
class_name Spikes
#controls the texture and collision shape rect size via a single pair of editable values

export var width = 128 setget set_width
export var height = 30 setget set_height
onready var area : Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", self, "spike_hit")
	on_changed()
	
func spike_hit(body : PhysicsBody2D):
	if body.is_in_group("MainBall"):
		GameManager.reset_level()

func set_width(new_width):
	#var offset = 64 - (new_width % 64)
	#new_width = new_width + offset
	if width != new_width:
		width = new_width
		on_changed()
		update()

func set_height(new_height):
	if height != new_height:
		height = new_height
		on_changed()
		update()

func on_changed():
	if get_child_count()>0:
		$TextureRect.rect_size = Vector2(width,height)
		$TextureRect.rect_position = Vector2(-width/2, -height/2)
		#$SpikeShape.shape.extents = Vector2(width/2, height/2)
		$Area2D/AreaShape.shape.extents = Vector2(width/2, height/2)
