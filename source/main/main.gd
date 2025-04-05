extends Node2D


@onready var background_floor: Polygon2D = $Background/Floor
@onready var background_floor_side: Polygon2D = $Background/Floor/FloorSide
@onready var game_camera: Camera2D = $GameCamera

var current_level

var fullscreen : bool = false
var game_camera_next_floor_distance_initial_y = 120
var game_camera_next_floor_distance_y : float
var game_camera_next_floor_distance_divisor_y = 2


func _ready() -> void:
	game_camera_next_floor_distance_y = game_camera_next_floor_distance_initial_y
	Database.load_values()


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
