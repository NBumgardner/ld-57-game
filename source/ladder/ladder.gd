extends Area2D


func _ready() -> void:
	set_deferred("monitoring", true)
	body_entered.connect(_on_body_entered_area)


func _on_body_entered_area(body: Node2D) -> void:
	if body is Player:
		set_deferred("monitoring", false)
		Events.transitioning_to_new_level.emit()
