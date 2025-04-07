extends Node

@onready var game_music: AudioStreamPlayer = $GameMusic


func _ready() -> void:
	set_game_music("Track 1")


func set_game_music(track_name : StringName = "Silence") -> void:
	game_music["parameters/switch_to_clip"] = track_name
