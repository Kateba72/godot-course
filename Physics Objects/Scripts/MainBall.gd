tool
extends RigidBody2D
class_name MainBall
#controls the color of the main ball

func _ready():
	$Sprite.modulate = Color(.69, .23, .14)

func level_completed():
	$AnimationPlayer.play("Disappear")

func go_to_sleep():
	can_sleep=true
	set_sleeping(true)
