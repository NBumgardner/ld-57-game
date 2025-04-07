extends Node

@onready var game_music: AudioStreamPlayer = $GameMusic

func _ready() -> void:
	Events.game_paused.connect(_on_game_paused)
	Events.game_unpaused.connect(_on_game_unpaused)
	set_game_music("Track 1")


func set_game_music(track_name : StringName = "Silence") -> void:
	game_music["parameters/switch_to_clip"] = track_name


func _on_game_paused() -> void:
	AudioServer.set_bus_effect_enabled(1, 1, true)


func _on_game_unpaused() -> void:
	AudioServer.set_bus_effect_enabled(1, 1, false)
