extends Node

var levels  = []
var num_levels = 0

var base_level_scene = preload("res://UI/Scenes/BaseLevel.tscn")
var main_menu_scene = preload("res://UI/Scenes/MainMenu.tscn")
var win_panel_scene = preload("res://UI/Scenes/WinPanel.tscn")

var base_level = null
var win_panel = null
var main_menu = null

var progress = {}
var last_completed_level_index: int = 0

var running_game : bool = false
var current_level_index : int = -1
var current_level_name = ""
var current_level : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	levels = Utilities.list_files_in_directory("res://Levels")
	levels.sort()
	num_levels = levels.size()
	var scene_name = get_tree().current_scene.filename.get_file()

	load_progress()

	if scene_name == "MainMenu.tscn":
		main_menu = get_tree().current_scene
		running_game = true
	else:
		main_menu = main_menu_scene.instance()
		current_level_index = levels.find(scene_name)
		if current_level_index >= 0:
			current_level = get_tree().current_scene
			call_deferred("load_base_level")
			running_game = true

func save_progress():
	var save_game = File.new()
	save_game.open("user://first_project.save", File.WRITE)
	print("Saving game...")
	save_game.store_string(to_json(progress))
	save_game.close()

func load_progress():
	var save_game = File.new()
	if save_game.file_exists("user://first_project.save"):
		save_game.open("user://first_project.save", File.READ)
		progress = parse_json(save_game.get_as_text())
		save_game.close()
		print("Game loaded")

	var last_completed_level = ""
	for level in levels:
		if not level in progress:
			progress[level] = {'star1': 0, 'star2': 0, 'star3': 0, 'completed': false}

		if progress[level]['completed']:
			last_completed_level = level

	last_completed_level_index = levels.find(last_completed_level)

func reset_progress():
	print("Resetting progress")
	var save_game = File.new()
	save_game.open("user://first_project.save", File.WRITE)
	save_game.store_string(to_json({}))
	save_game.close()
	load_progress()
	
func cheat_progress():
	for level in levels:
		progress[level] = {}
		progress[level]['completed'] = true
	save_progress()

func unload_current_level():
	unload_base_level()
	if win_panel != null:
		unload_win_panel()
	if current_level != null:
		unload_scene(current_level)
		current_level = null

func load_level(i: int):
	var level_scene = load("res://Levels/"+levels[i])
	current_level_index = i
	current_level_name = levels[i]
	for i in range(1, 4):
		if 'star'+str(i) in progress[current_level_name] and progress[current_level_name]['star'+str(i)]:
			progress[current_level_name]['star'+str(i)] = 1
		else:
			progress[current_level_name]['star'+str(i)] = 0
	current_level = load_scene(level_scene)
	load_base_level()
	current_level.connect("tree_entered", GameManager, "load_base_level")

func load_next_level():
	unload_current_level()
	load_level(current_level_index + 1)

func on_level_passed(stars_picked_up):
	for i in range(3):
		progress[current_level_name]['star'+str(i+1)] = stars_picked_up[i]
	progress[current_level_name]['completed'] = true
	if current_level_index > last_completed_level_index:
		last_completed_level_index = current_level_index
	save_progress()
	load_win_panel()

func reset_level():
	unload_current_level()
	load_level(current_level_index)

func unload_win_panel():
	unload_scene(win_panel)
	win_panel = null

func load_win_panel():
	win_panel = load_scene(win_panel_scene)

func unload_base_level():
	unload_scene(base_level)
	base_level = null

func load_base_level():
	base_level = load_scene(base_level_scene)

func load_menu():
	main_menu = load_scene(main_menu_scene)

func unload_menu():
	unload_scene(main_menu)
	main_menu = null

func unload_scene(root : Node):
	root.queue_free()

func load_scene(scene : PackedScene) -> Node:
	var root = scene.instance()
	get_tree().get_root().add_child(root)
	return root
