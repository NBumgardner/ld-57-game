extends Node


@onready var background_floor: Polygon2D = $Background/Floor
@onready var background_floor_side: Polygon2D = $Background/FloorSide


var fullscreen : bool = false


func _ready() -> void:
	pass


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
