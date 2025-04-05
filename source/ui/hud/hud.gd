extends Control


@onready var floor_count_amount_display = $TopGameStatus/HBoxContainer2/FloorCount
@onready var player_health_amount_display = $TopGameStatus/HBoxContainer/HealthAmount


func ready():
	_set_floor_count_text(Database.floor_count)
	Database.floor_count_changed.connect(_set_floor_count_text)

	_set_health_text(Database.player_health_current)
	Database.health_changed.connect(_set_health_text)


func _set_floor_count_text(new_floor_count) -> void:
	floor_count_amount_display.text = str(new_floor_count)


func _set_health_text(new_health: int, _old_health: int = 0) -> void:
	player_health_amount_display.text = str(new_health)
