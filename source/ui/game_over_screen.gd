extends Control

@onready var restart_button: Button = %RestartButton


func _ready() -> void:
	hide()
	Events.game_ended.connect(_on_game_over)
	restart_button.pressed.connect(_on_restart_button_pressed)


func _on_game_over() -> void:
	self.show()


func _on_restart_button_pressed() -> void:
	Events.game_started.emit()
	self.hide()
