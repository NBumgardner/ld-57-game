class_name Hud
extends Control


@onready var floor_count_amount_display = %FloorCount
@onready var player_health_amount_display = %HealthAmount
@onready var cheese_count: Label = %CheeseCount



func _ready():
	Database.floor_count_changed.connect(_on_floor_changed)
	Database.health_changed.connect(_set_health_text)
	_set_health_text(Database.player_health_current)


func _set_health_text(new_health: int, _old_health: int = 0) -> void:
	player_health_amount_display.text = str(new_health)


func _on_floor_changed(new_floor_count : int = 1) -> void:
	floor_count_amount_display.text = str(new_floor_count)
