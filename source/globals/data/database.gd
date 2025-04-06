# Defines variables shared across scenes with the correct data types.
extends Node


signal floor_count_changed(new_floor_count: int)
signal health_changed(new_value: int, old_value: int)


const _initial_floor_count: int = 1
const _initial_player_health_current: int = 2
const _initial_player_health_maximum: int = 2


var floor_count: int
var player_health_current: int
var player_health_maximum: int


func _ready():
	load_values()


func load_values():
	set_floor_count(_initial_floor_count)
	set_player_health_current(_initial_player_health_current)
	set_player_health_maximum(_initial_player_health_maximum)


#region Setters

func set_floor_count(updated_count: int) -> void:
	floor_count = updated_count
	floor_count_changed.emit(updated_count)


func set_player_health_current(updated_health: int) -> void:
	var old_health = player_health_current
	player_health_current = updated_health
	health_changed.emit(updated_health, old_health)


func set_player_health_maximum(updated_health: int) -> void:
	player_health_maximum = updated_health

#endregion Setters
