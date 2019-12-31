extends Node2D
class_name Goal

onready var goal_area = $Area2D

var level_was_completed : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#call "on_body_enter" when the Area2D emits the "body_entered" signal
	goal_area.connect("body_entered", self, "on_body_enter")

func on_body_enter(body : PhysicsBody2D):
	if !level_was_completed and body.is_in_group("MainBall"): #we use the "MainBall" group tag to identify the ball
		body.level_completed()
		level_completed()

# add level completed logic here
func level_completed():
	print("Level complete")
	level_was_completed = true
	yield (get_tree().create_timer(0.2),"timeout") #wait 0.2 seconds
	GameManager.base_level.on_level_passed()
