extends Node

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
