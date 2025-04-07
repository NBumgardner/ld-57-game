extends Area2D

@onready var sfx_nibble: AudioStreamPlayer2D = $"SFX|Nibble"

func _ready() -> void:
	body_entered.connect(_on_body_entered_area)


func _on_body_entered_area(_body : Node2D) -> void:
	set_deferred("monitoring", false)
	Database.cheese_count += 1
	hide()
	sfx_nibble.play()
	await sfx_nibble.finished
	queue_free()
