extends Node

var levels  = []

var main_menu_scene = preload("res://UI/Scenes/MainMenu.tscn")
var options_bar_scene = preload("res://UI/Scenes/OptionsBar.tscn")
var win_panel_scene = preload("res://UI/Scenes/WinPanel.tscn")

var options_bar = null
var win_panel = null
var main_menu = null

var running_game : bool = false
var current_level_index : int = -1
var current_level_jndex : int = -1
var current_level : Node

# Called when the node enters the scene tree for the first time.
func _ready():
    var levels_ = Utilities.list_files_in_directory("res://Levels")
    levels_.sort()
    for level in levels_:
        var components = level.split(".")[0].split("_", true, 3)
        var level_level_number = int(components[1])
        var level_number = int(components[2])
        var level_name = components[3]
        if levels.size() <= level_level_number:
            levels.append([])
        levels[level_level_number].append([level, level_name])
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
            running_game = true

func unload_current_level():
    unload_options_bar()
    if win_panel != null:
        unload_win_panel()
    unload_scene(current_level)
    current_level = null

func load_level(i: int, j: int):
    var level_scene = load("res://Levels/" + levels[i][j][0])
    current_level = load_scene(level_scene)
    load_options_bar()
    options_bar.title_label.text = levels[i][j][1]
    current_level_index = i
    current_level_jndex = j
    current_level.connect("tree_entered", GameManager, "load_options_bar")	

func has_next_level() -> bool:
    return (current_level_index + 1 < levels.size()) or (current_level_jndex + 1 < levels[current_level_index].size())

func load_next_level():
    unload_current_level()
    if current_level_jndex + 1 == levels[current_level_index].size():
        load_level(current_level_index + 1, 0)
    else:
        load_level(current_level_index, current_level_jndex + 1)

func on_level_passed():
    load_win_panel()

func reset_level():
    unload_current_level()
    load_level(current_level_index, current_level_jndex)

func unload_win_panel():
    unload_scene(win_panel)
    win_panel = null

func load_win_panel():
    win_panel = load_scene(win_panel_scene)

func unload_options_bar():
    unload_scene(options_bar)
    options_bar = null

func load_options_bar():
    options_bar = load_scene(options_bar_scene)

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

