tool
extends StaticBody2D
class_name Platform
#controls the texture and collision shape rect size via a single pair of editable values

export var width = 300 setget set_width
export var height = 30 setget set_height

# Called when the node enters the scene tree for the first time.
func _ready():
	on_changed()

func set_width(new_width):
	if width != new_width:
		width = new_width
		var particles = $Particles2D
		if particles != null:
			particles.get_process_material().set_emission_box_extents(Vector3(width/2,height,0))
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
		$CollisionShape2D.shape.extents = Vector2(width/2, height/2)
