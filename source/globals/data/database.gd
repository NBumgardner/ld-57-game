# Defines variables shared across scenes with the correct data types.
extends Node


signal floor_count_changed(new_floor_count: int)
signal health_changed(new_value: int, old_value: int)
signal cheese_count_changed(new_value: int)

const _initial_floor_count: int = 1
const _initial_player_health_maximum: int = 10
const _initial_cheese_count : int = 0


var floor_count: int = _initial_floor_count:
	set(updated_count):
		floor_count = updated_count
		floor_count_changed.emit(floor_count)

var player_health_current: int = _initial_player_health_maximum:
	set(updated_health):
		var old_health = player_health_current
		player_health_current = min(updated_health, player_health_maximum)
		health_changed.emit(player_health_current, old_health)

var player_health_maximum: int = _initial_player_health_maximum:
	set(updated_health):
		player_health_maximum = updated_health

var cheese_count: int = _initial_cheese_count:
	set(updated_count):
		cheese_count = updated_count
		cheese_count_changed.emit(cheese_count)


func _ready():
	pass
