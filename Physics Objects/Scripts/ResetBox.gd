extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#call "on_body_exit" when the Area2D emits the "body_exited" signal
	connect("body_exited", self, "on_body_exit")  

func on_body_exit(body : PhysicsBody2D):
	if body.is_in_group("MainBall"): #we use the "MainBall" group tag to identify the ball
		GameManager.reset_level()