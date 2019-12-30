extends Panel

# Declare member variables here. Examples:
onready var star1 : Sprite =$Star1
onready var star2 : Sprite =$Star2
onready var star3 : Sprite =$Star3
var starCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_stars()
	pass # Replace with function body.

func get_star_count():
	return starCount

func initialize_stars():
	starCount = 0
	star1.texture = load("res://Physics Objects/Textures/star.png")
	star2.texture = load("res://Physics Objects/Textures/star.png")
	star3.texture = load("res://Physics Objects/Textures/star.png")

func set_star_count(val):
	initialize_stars()
	starCount = val
	GameManager.current_star_count = val
	if starCount > 0:
		star1.texture = load("res://Physics Objects/Textures/staryellow.png")
	if starCount > 1:
		star2.texture = load("res://Physics Objects/Textures/staryellow.png")
	if starCount > 2:
		star3.texture = load("res://Physics Objects/Textures/staryellow.png")
	if starCount > 3:
		print("Too many stars!")

func playAnimation():
	$AnimationPlayer.play("StarCollect")

func add_star():
	set_star_count(get_star_count()+1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
