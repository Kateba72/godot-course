extends Node2D
class_name Pickable

onready var area : Area2D = $Body/Area2D
onready var pickable_body : Node = $Body
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer
onready var particles : Particles2D = $Particles2D
export var index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", self, "on_body_enter")  
	if animation_player != null:
		animation_player.play("idle")

func on_body_enter(body : PhysicsBody2D):
	if body.is_in_group("MainBall"):
		pick_up()

func pick_up():
	if audio_player != null:
		audio_player.play()
	if particles != null:
		particles.emitting = true
	pickable_body.visible = false
	area.monitoring = false
	GameManager.base_level.pick_up_star(index)
	
	#delete after pick up effects?