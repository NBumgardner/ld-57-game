extends Node2D

signal player_entered_area


func _ready() -> void:
	pass


func _on_body_entered_area(body: Node2D) -> void:
	if body is Player:
		pass
