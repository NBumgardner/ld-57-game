extends Area2D

@onready var sfx_nibble: AudioStreamPlayer2D = $"SFX|Nibble"

func _ready() -> void:
	body_entered.connect(_on_body_entered_area)


func _on_body_entered_area(_body : Node2D) -> void:
	Database.cheese_count += 1
	hide()
	set_deferred("monitoring", false)
	sfx_nibble.play()
	await sfx_nibble.finished
	queue_free()
