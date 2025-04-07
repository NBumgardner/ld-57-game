class_name HealthComponent
extends Node2D


var max_health : float = 10
var current_health : float = 10:
	set(new_health):
		current_health = clamp(new_health,0,max_health)


func take_damage() -> void:
	pass
