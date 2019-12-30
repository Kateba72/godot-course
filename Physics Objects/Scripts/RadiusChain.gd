tool
class_name RadiusChain
extends Node2D
    
var hook = preload("res://Physics Objects/Scenes/ChainLinkHook.tscn")
var link = preload("res://Physics Objects/Scenes/ChainLink.tscn")

onready var circle : Area2D =$Circle
onready var collisionShape : CollisionShape2D = $Circle/CircleShape # DOWSNT WORK, WHY NOT?
export var radius = 128 setget set_radius

var connected_body : PhysicsBody2D

var recursive: bool = false
var wait_first: bool = true
var unfreeze: bool = true

var ropeset: bool = false # Has the rope already found a ball to connect to?

func _ready():
	circle.connect("body_entered", self, "on_body_enter")  
	set_radius(radius)

func on_body_enter(body : PhysicsBody2D):
	if body.is_in_group("MainBall"):
		ropeset = true
		connected_body = body
		buildRope()

func buildRope():
    var total_delta_vector = to_local(connected_body.global_position)
    total_delta_vector = total_delta_vector * max(total_delta_vector.length() - 30, 10) / (total_delta_vector.length())
    var links = int(total_delta_vector.length() / 10)
    var current_hook = hook.instance()
    add_child(current_hook)
    current_hook.set_position(Vector2(0, 0))
    var last_link = current_hook
    var delta_vector = total_delta_vector / (links - 1)
    var all_links = []
    for index in (links - 1):
        var current_link = link.instance()
        last_link.manually_connected_body = current_link
        if recursive:
            last_link.add_child(current_link)
            current_link.set_position(delta_vector)
        else:
            add_child(current_link)
            current_link.set_position(delta_vector * (index + 1))
        if wait_first:
            all_links.append(last_link)
            current_link.mode = RigidBody.MODE_STATIC
        else:
            last_link.manual_configure()
        last_link = current_link
    last_link.manually_connected_body = connected_body
    if wait_first:
        all_links.append(last_link)
        connected_body.mode = RigidBody.MODE_STATIC
    else:
        last_link.manual_configure()

    if wait_first:
        yield(get_tree(), "idle_frame")
        for link in all_links:
            link.manual_configure()
        yield(get_tree(), "idle_frame")
        if unfreeze:
            connected_body.mode = RigidBody.MODE_RIGID
            connected_body.apply_impulse(Vector2(0,0), Vector2(0, 0))
            for link in all_links:
                if link != current_hook:
                    link.mode = RigidBody.MODE_RIGID

func set_radius(val):
	radius = val
	if collisionShape != null:
		collisionShape.get_shape().radius = val
	$Radius.scale = Vector2(val/128,val/128)