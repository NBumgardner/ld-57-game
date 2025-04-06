extends Control


func _ready() -> void:
	hide()
	Events.game_paused.connect(_on_game_paused)
	Events.game_unpaused.connect(_on_game_unpaused)


func _on_game_paused() -> void:
	show()


func _on_game_unpaused() -> void:
	hide()
