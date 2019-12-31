extends Node2D
class_name Pickable

onready var area : Area2D = $Body/Area2D
onready var pickable_body : Node = $Body
onready var animation_player : AnimationPlayer = $AnimationPlayer
onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer
onready var particles : Particles2D = $Particles2D
export var index: int
var precollected = false
var picked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", self, "on_body_enter")
	area.connect("mouse_entered",self, "twinkle")
	if animation_player != null:
		animation_player.play("starAnimation")

func on_body_enter(body : PhysicsBody2D):
	if body.is_in_group("MainBall"):
		pick_up()

func set_precollected(value: bool):
	precollected = value
	print(name)
	if value:
		modulate = Color(.5, .5, .5)
		$Body/Glow.visible = false
	else:
		modulate = Color(1, 1, 1)

func pick_up():
	if not picked:
		picked = true
		if audio_player != null:
			audio_player.play()
		if particles != null:
			particles.emitting = false
		pickable_body.visible = false
		area.set_deferred("monitoring", false)
		GameManager.base_level.pick_up_star(index)

func twinkle():
	pass
