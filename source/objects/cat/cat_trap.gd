class_name CatTrap
extends Area2D

@onready var cat_hand: Sprite2D = $CatHand
@onready var spot_light: Sprite2D = $SpotLight
@onready var animation: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	body_entered.connect(_on_body_entered_area)


func _on_body_entered_area(body: Node2D) -> void:
	if body is Player:
		animation.play("drop_hand")
