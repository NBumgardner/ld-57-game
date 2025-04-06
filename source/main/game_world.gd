class_name GameWorld
extends Node2D

const levels : Array = preload("res://source/levels/game_levels.tres").levels

@export var current_level : Level
var current_level_id : int = 0
@export var game_camera: Camera2D
@export var player: Player


func _ready() -> void:
	Events.transitioning_to_new_level.connect(load_next_level)
	current_level.start_level()


func load_next_level() -> void:
	await get_tree().create_timer(0.2).timeout
	current_level_id = wrap(current_level_id + 1, 0, levels.size())
	Database.floor_count += 1
	var next_level : PackedScene = levels[current_level_id]
	var old_level : Level = current_level
	var new_level : Level = next_level.instantiate()
	player.set_deferred("process_mode", PROCESS_MODE_DISABLED)
	call_deferred("add_child",new_level)
	current_level = new_level
	
	if old_level: old_level.queue_free()
	new_level.call_deferred("start_level")
	player.global_position = new_level.player_spawn_point.global_position
	player.set_deferred("process_mode", PROCESS_MODE_INHERIT)
