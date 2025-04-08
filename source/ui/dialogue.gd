class_name Dialogue
extends Control

@onready var dialouge_label: Label = %DialougeLabel
@onready var yes_button: SoundButton = %YesButton
@onready var no_button: SoundButton = %NoButton
@onready var sfx_consume: AudioStreamPlayer = $"SFX|Consume"


func _ready() -> void:
	self.hide()
	yes_button.pressed.connect(_on_yes_pressed)
	no_button.pressed.connect(_on_no_pressed)
	Events.start_dialogue.connect(start_animation)
	Events.end_dialogue.connect(animation_exit)
	#self.hide()
	#dialouge_label.visible_ratio = 0.0


func start_animation() -> void:
	check_cheese_status()
	#animation.play("start")
	self.show()


func check_cheese_status() -> void:
	if Database.cheese_count <= 0:
		yes_button.disabled = true
	else:
		yes_button.disabled = false


func _on_yes_pressed() -> void:
	sfx_consume.play()
	Database.cheese_count -= 1
	check_cheese_status()


func _on_no_pressed() -> void:
	animation_exit()


func animation_exit() -> void:
	#animation.play("exit")
	self.hide()
