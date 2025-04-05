class_name Level
extends Node2D

@export var player_spawn_point : Node2D


func _ready() -> void:
	hide()
	y_sort_enabled = true


func start_level() -> void:
	show()
	set_deferred("process_mode",PROCESS_MODE_INHERIT)
