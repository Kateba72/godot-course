
extends Node2D
class_name MagicChain
    
var hook = preload("res://Physics Objects/Scenes/ChainLinkHook.tscn")
var link = preload("res://Physics Objects/Scenes/ChainLink.tscn")

export var connected_body_path : NodePath
onready var connected_body : PhysicsBody2D = get_node(connected_body_path)

var recursive: bool = false
var wait_first: bool = true
var unfreeze: bool = true

func _ready():
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