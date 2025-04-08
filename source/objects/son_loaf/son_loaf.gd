extends Area2D


func _ready() -> void:
	body_entered.connect(_on_fathers_approach)
	body_exited.connect(_on_fathers_leave)



func _on_fathers_approach(_body: Node2D) -> void:
	Events.start_dialogue.emit()


func _on_fathers_leave(_body: Node2D) -> void:
	Events.end_dialogue.emit()
