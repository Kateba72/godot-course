extends Node2D

export var connected_body_path : NodePath
onready var connected_body : PhysicsBody2D = get_node(connected_body_path)

onready var joint = $PinJoint2D
onready var line = $Line2D

var mouse_pos : Vector2
var prev_mouse_pos : Vector2
var was_mouse_pressed : bool = false

var rope_on : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	if connected_body != null:
		rope_on = true
		joint.node_b = NodePath("../" + connected_body_path)

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rope_on:
		#update line renderer with point positions
		var points : Array = []
		points.append(Vector2(0,0))
		#print(connected_body)
		points.append(to_local(connected_body.global_position))
		line.points = points

		#check for mouse input
		mouse_pos = get_viewport().get_mouse_position()
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and was_mouse_pressed:
			if Utilities.do_intersect(prev_mouse_pos,mouse_pos, global_position, connected_body.global_position):
				cut_rope()
		prev_mouse_pos = mouse_pos
		was_mouse_pressed = Input.is_mouse_button_pressed(BUTTON_LEFT)


func cut_rope():
	rope_on = false
	line.points = []
	joint.node_b = NodePath()
