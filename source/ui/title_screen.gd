extends Control

@onready var start_button: Button = %StartButton


@export var first_level : String = "uid://ri8nlljydju3"


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)


func _on_start_button_pressed() -> void:
	Events.level_load_started.emit(first_level)
	self.hide()
