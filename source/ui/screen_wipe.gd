class_name ScreenWipe
extends Control

@onready var screen_cover: ColorRect = $ScreenCover
@onready var animation: AnimationPlayer = $AnimationPlayer


func wipe_start() -> void:
	animation.play("cover")
	await animation.animation_finished
	wipe_end()


func wipe_end() -> void:
	animation.play("reveal")


func _on_ladder_body_entered(_body: Node2D) -> void:
	wipe_start()
