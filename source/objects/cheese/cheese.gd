extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered_area)


func _on_body_entered_area(_body : Node2D) -> void:
	Database.cheese_count += 1
	queue_free()
