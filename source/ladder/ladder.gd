extends Node2D


func _ready() -> void:
	pass


func _process(_elta: float) -> void:
	pass


func _on_body_entered(body):
	print_debug("Ladder overlap detected for body:", body)
