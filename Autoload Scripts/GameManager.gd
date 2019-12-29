extends Node

var levels  = []
var num_levels = 0

var main_menu_scene = preload("res://UI/Scenes/MainMenu.tscn")
var options_bar_scene = preload("res://UI/Scenes/OptionsBar.tscn")
var reset_box_scene = preload("res://Physics Objects/Scenes/ResetBox.tscn")
var win_panel_scene = preload("res://UI/Scenes/WinPanel.tscn")

var options_bar = null
var reset_box = null
var win_panel = null
var main_menu = null

var running_game : bool = false
var current_level_index : int = -1
var current_level : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	levels = Utilities.list_files_in_directory("res://Levels")
	levels.sort()
	num_levels = levels.size()
	var scene_name = get_tree().current_scene.filename.get_file()

	if scene_name == "MainMenu.tscn":
		main_menu = get_tree().current_scene
		running_game = true
	else: 
		main_menu = main_menu_scene.instance()
		current_level_index = levels.find(scene_name)
		if current_level_index >= 0:
			current_level = get_tree().current_scene
			call_deferred("load_options_bar")
			call_deferred("load_reset_box")
			running_game = true

func unload_current_level():
	unload_options_bar()
	unload_reset_box()
	if win_panel != null:
		unload_win_panel()
	if current_level != null:
		unload_scene(current_level)
		current_level = null

func load_level(i: int):		
	var level_scene = load("res://Levels/"+levels[i])
	current_level = load_scene(level_scene)
	load_options_bar()
	load_reset_box()
	current_level_index = i
	current_level.connect("tree_entered", GameManager, "load_options_bar")
	current_level.connect("tree_entered", GameManager, "load_reset_box")

func load_next_level():
	unload_current_level()
	load_level(current_level_index +1)

func on_level_passed():
	load_win_panel()

func reset_level():
	unload_current_level()
	load_level(current_level_index)

func unload_win_panel():
	unload_scene(win_panel)
	win_panel = null
	
func load_win_panel():
	win_panel = load_scene(win_panel_scene)

func unload_options_bar():
	unload_scene(options_bar)
	options_bar = null

func unload_reset_box():
	unload_scene(reset_box)
	reset_box = null

func load_options_bar():
	options_bar = load_scene(options_bar_scene)

func load_reset_box():
	reset_box = load_scene(reset_box_scene)

func load_menu():
	main_menu = load_scene(main_menu_scene)

func unload_menu():
	unload_scene(main_menu)
	main_menu = null

func unload_scene(root : Node):
	root.queue_free()

func pick_up_star(n: int):
	options_bar.pick_up_star(n)

func load_scene(scene : PackedScene) -> Node:
	var root = scene.instance()
	get_tree().get_root().add_child(root)
	return root
