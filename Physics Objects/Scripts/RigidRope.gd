extends Node2D

export var connected_body_path : NodePath
export var joints_number = 10
onready var connected_body : PhysicsBody2D = get_node(connected_body_path)

onready var joint = $PinJoint2D
onready var line = $Line2D

var mouse_pos : Vector2
var prev_mouse_pos : Vector2
var was_mouse_pressed : bool = false

var RopePart = load("res://Physics Objects/Scenes/RopePart.tscn")
var Star = load("res://Physics Objects/Scenes/Star.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	if connected_body != null:
		var last_joint = joint
		for i in range(joints_number + 1):
			var rope_part = Node2D.new()
			var pinjoint = PinJoint2D.new()
			var chainlink = RigidBody2D.new()
			var collision_shape = CollisionShape2D.new()
			var sprite = Sprite.new()
			var line = Line2D.new()
			rope_part.add_child(pinjoint)
			rope_part.add_child(chainlink)
			rope_part.add_child(line)
			chainlink.add_child(collision_shape)
			chainlink.add_child(sprite)
			sprite.texture = load("res://Physics Objects/Textures/hook_in.png")
			pinjoint.node_a = chainlink.get_path()
			pinjoint.node_b = last_joint.get_path()
			collision_shape.set_shape(CircleShape2D.new())
			last_joint = pinjoint
			collision_shape
			
		last_joint.node_b = NodePath("../" + connected_body_path)