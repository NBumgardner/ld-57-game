extends Node2D

const levels : Array = preload("res://source/levels/game_levels.tres").levels

@export var current_level : Level
var current_level_id : int = 0

@onready var background_floor: Polygon2D = $Background/Floor
@onready var background_floor_side: Polygon2D = $Background/Floor/FloorSide
@onready var game_camera: Camera2D = $GameCamera

@onready var player: Player = $Player

var fullscreen : bool = false
var game_camera_next_floor_distance_initial_y = 120
var game_camera_next_floor_distance_y : float
var game_camera_next_floor_distance_divisor_y = 2

@onready var screen_wipe: ScreenWipe = $UI/ScreenWipe


func _ready() -> void:
	game_camera_next_floor_distance_y = game_camera_next_floor_distance_initial_y
	Database.load_values()
	Events.transitioning_to_new_level.connect(load_next_level)
	if current_level:
		current_level.start_level()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen_toggle"):
		fullscreen = !fullscreen
		if fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	if event.is_action_pressed("debug_skip_down"):
		print_debug("Debug skip to next lower floor.")
		transition_to_floor_next_lower()


func transition_to_floor_next_lower():
	background_floor.visible = false
	background_floor_side.visible = false

	if game_camera_next_floor_distance_y < 1:
		print_debug("Keep camera still since vector y movement would be less than 1.")
		return

	game_camera.set_position(
		game_camera.get_position()
		+ Vector2(0, game_camera_next_floor_distance_y)
	)
	game_camera_next_floor_distance_y = (
		game_camera_next_floor_distance_y
		/ game_camera_next_floor_distance_divisor_y
	)


func load_next_level() -> void:
	screen_wipe.wipe_start()
	await screen_wipe.animation.animation_finished
	
	current_level_id = wrap(current_level_id + 1, 0, levels.size())
	var next_level : PackedScene = levels[current_level_id]
	var old_level : Level = current_level
	var new_level : Level = next_level.instantiate()
	player.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	call_deferred("add_child",new_level)
	current_level = new_level
	
	if old_level: old_level.queue_free()
	new_level.call_deferred("start_level")
	#player.global_position = new_level.player_spawn_point.global_position
	player.set_deferred("process_mode", PROCESS_MODE_INHERIT)
