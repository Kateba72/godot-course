extends Node2D

export var connected_body_path : NodePath
onready var connected_body : PhysicsBody2D = get_node(connected_body_path)
var manually_connected_body: PhysicsBody2D

onready var joint = $PinJoint2D
onready var line = $Line2D

var rope_on : bool

var mouse_pos : Vector2
var prev_mouse_pos : Vector2
var was_mouse_pressed : bool = false
var dead: bool = false

func _ready():
    if joint != null:
        joint.node_b = NodePath()

# Called when the node enters the scene tree for the first time.
func manual_configure():
    rope_on = true
    if joint != null:
        if has_node("Chain"):
            connected_body = get_node("Chain")
        if manually_connected_body != null:
            connected_body = manually_connected_body
        joint.node_b = connected_body.get_path()

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if (rope_on
            and connected_body != null
            and weakref(connected_body).get_ref()
            and not (connected_body.has_method("dead_get") and connected_body.dead)
            ):
        #update line renderer with point positions
        line.points = [Vector2(0,0), to_local(connected_body.global_position)]
        
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
    yield(get_tree().create_timer(0.01), "timeout")
    if (connected_body != null 
            and connected_body != null
            and weakref(connected_body).get_ref()
            and not (connected_body.has_method("dead_get") and connected_body.dead)
            and connected_body.has_method("cut_rope") 
            ):
        connected_body.cut_rope()
        connected_body.dead = true
        yield(get_tree().create_timer(0.1), "timeout")
        connected_body.queue_free()