extends Control

@onready var resume_bttn: Button = %ResumeBttn


func _ready() -> void:
	hide()
	Events.game_paused.connect(_on_game_paused)
	Events.game_unpaused.connect(_on_game_unpaused)
	resume_bttn.pressed.connect(_on_resume_bttn_pressed)


func _on_game_paused() -> void:
	show()
	resume_bttn.grab_focus()


func _on_game_unpaused() -> void:
	hide()


func _on_resume_bttn_pressed() -> void:
	Events.game_unpaused.emit()
