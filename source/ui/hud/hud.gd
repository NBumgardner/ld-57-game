class_name Hud
extends Control


@onready var floor_count_amount_display = %FloorCount
@onready var player_health_amount_display = %HealthAmount
@onready var cheese_count: Label = %CheeseCount



func _ready():
	modulate.a = 0.0
	Database.floor_count_changed.connect(_on_floor_changed)
	Database.health_changed.connect(_set_health_text)
	Database.cheese_count_changed.connect(_on_cheese_count_changed)
	_set_health_text(Database.player_health_current)
	Events.level_transition_started.connect(_on_transition_started)
	Events.level_transition_completed.connect(_on_transition_ended)
	Events.game_ended.connect(_on_game_ended)


func _set_health_text(new_health: int, _old_health: int = 0) -> void:
	player_health_amount_display.text = str(new_health)


func _on_floor_changed(new_floor_count : int = 1) -> void:
	floor_count_amount_display.text = str(new_floor_count)


func _on_cheese_count_changed(new_cheese_count : int = 0) -> void:
	cheese_count.text = str(new_cheese_count)


func _on_transition_started() -> void:
	var tween = create_tween()
	tween.tween_property(self,"modulate:a",0.0,0.2)


func _on_transition_ended() -> void:
	var tween = create_tween()
	tween.tween_property(self,"modulate:a",1.0,0.3)


func _on_game_ended() -> void:
	var tween = create_tween()
	tween.tween_property(self,"modulate:a",0.0,0.2)
	
