extends Area2D

# Declare member variables here. Examples:
var isActive = true
onready var sprite = $Sprite
export var force = 500
onready var animationplayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "on_body_enter") 
	pass # Replace with function body.
	
func on_body_enter(body : PhysicsBody2D):
	if body.is_in_group("MainBall") and isActive:
		activate(body)

func activate(body : PhysicsBody2D):
	print("Is activated!")
	isActive = false
	animationplayer.play("boostAnimation")
	sprite.texture =  load("res://Physics Objects/Textures/boostused.png")
	var x1 = force
	var y1 = force
	var x2 = cos(rotation_degrees)*x1 - sin(rotation_degrees)*y1
	var y2 = sin(rotation_degrees)*x1 + cos(rotation_degrees)*y1
	body.apply_impulse(Vector2(0,0),Vector2(x2,y2))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
