# Defines variables shared across scenes with the correct data types.
extends Node


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


#region Setters

func set_floor_count(updated_count: int) -> void:
	floor_count = updated_count


func set_player_health_current(updated_health: int) -> void:
	player_health_current = updated_health


func set_player_health_maximum(updated_health: int) -> void:
	player_health_maximum = updated_health

#endregion Setters
