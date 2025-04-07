class_name HealthComponent
extends Area2D

signal death
signal health_changed

@export var max_health : float = 10:
	set(new_max_health):
		max_health = new_max_health
		health_changed.emit(current_health, max_health)
var current_health : float = max_health:
	set(new_health):
		current_health = clamp(new_health,0,max_health)
		health_changed.emit(current_health, max_health)
		if current_health == 0:
			death.emit()


func take_damage(amount) -> void:
	current_health -= amount
