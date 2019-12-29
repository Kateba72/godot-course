extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_text("Stars " + str(count))
	pass # Replace with function body.


func incrementCount():
	count= count +1
	set_text("Stars " + str(count))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
