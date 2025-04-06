# Defines variables shared across scenes with the correct data types.
extends Node


signal floor_count_changed(new_floor_count: int)
signal health_changed(new_value: int, old_value: int)


const _initial_floor_count: int = 1
const _initial_player_health_current: int = 2
const _initial_player_health_maximum: int = 2


var floor_count: int:
	set(updated_count):
		floor_count = updated_count
		floor_count_changed.emit(floor_count)

var player_health_current: int:
	set(updated_health):
		var old_health = player_health_current
		player_health_current = min(updated_health, player_health_maximum)
		health_changed.emit(player_health_current, old_health)

var player_health_maximum: int:
	set(updated_health):
		player_health_maximum = updated_health


func _ready():
	load_values()


func load_values():
	floor_count = _initial_floor_count
	player_health_current = _initial_player_health_current
	player_health_maximum = _initial_player_health_maximum
