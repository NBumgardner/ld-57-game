class_name Ladder
extends Area2D

## Insert a UID to the next level. 
## You can get this by right-clicking on the tscn in the FileSystem.
@export var next_level_filepath : String = ""


func _ready() -> void:
	body_entered.connect(_on_body_entered_area)


func _on_body_entered_area(body: Node2D) -> void:
	if body is Player:
		set_deferred("monitoring", false)
		
		if next_level_filepath:
			Events.level_load_started.emit(next_level_filepath)
		else:
			Events.level_load_started.emit()
