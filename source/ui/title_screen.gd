extends Control

@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton


@export var first_level : String = "uid://ri8nlljydju3"


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	if OS.get_name() == "Web":
		quit_button.visible = false


func _on_start_button_pressed() -> void:
	Events.game_started.emit()
	self.hide()


func _on_quit_button_pressed() -> void:
	get_tree().quit()
