class_name GameWorld
extends Node2D

@export var game_camera: Camera2D
@export var player: Player
@export var starting_level : String = "uid://ri8nlljydju3"
var current_level : Level


#region Load variables
var load_path : String = ""
var load_status : ResourceLoader.ThreadLoadStatus = ResourceLoader.THREAD_LOAD_LOADED
#endregion Load variables

func _ready() -> void:
	Events.level_load_started.connect(load_level)
	Events.game_started.connect(_on_game_started)


func _on_game_started() -> void:
	Events.level_load_started.emit(starting_level)


func _process(_delta: float) -> void:
	if load_status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		update_load_status()


#region Loading
func load_level(level_path : String = "uid://6ujytfaku6kd") -> void:
	if level_path == "":
		printerr("Provided file path is blank")
		reset_load_status()
		return
	
	if level_path.is_absolute_path() or level_path.is_relative_path():
		load_path = level_path
		if OS.has_feature("thread"):
			ResourceLoader.load_threaded_request(load_path,"",true)
			load_status = ResourceLoader.load_threaded_get_status(load_path)
			
		else:
			var level_scene := ResourceLoader.load(load_path)
			transition_to_next_level(level_scene)
	
	else: printerr("Invalid file path for new level")


func update_load_status() -> void:
	load_status = ResourceLoader.load_threaded_get_status(load_path)
	if load_status == ResourceLoader.THREAD_LOAD_LOADED:
		transition_to_next_level(ResourceLoader.load_threaded_get(load_path))
	elif load_status == ResourceLoader.THREAD_LOAD_FAILED:
		printerr("Resource loading failed. Check that this file path is correct: \"", load_path,"\"")
		reset_load_status()


func transition_to_next_level(next_level : PackedScene) -> void:
	reset_load_status()
	
	var old_level : Level = current_level
	var new_level : Level = next_level.instantiate()
	await get_tree().process_frame
	call_deferred("add_child",new_level)
	current_level = new_level
	
	new_level.call_deferred("start_level")
	if old_level: old_level.call_deferred("end_level")
	
	Database.floor_count += 1


func reset_load_status() -> void:
	load_path = ""
	load_status = ResourceLoader.THREAD_LOAD_LOADED
#endregion Loading


func find_level() -> void:
	for node in get_children():
		if node is Level:
			current_level = node
			current_level.start_level()
			break
