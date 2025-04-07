class_name CatTrap
extends Area2D

@onready var cat_hand: Sprite2D = $CatHand
@onready var spot_light: Sprite2D = $SpotLight
@onready var animation: AnimationPlayer = $AnimationPlayer

@export var damage : float = 2
@export var trap_ready : bool = true

func _ready() -> void:
	body_entered.connect(_on_body_entered_area)
	cat_hand.hide()


func _on_body_entered_area(_body: Node2D) -> void:
	if trap_ready:
		animation.play("drop_hand")


func _on_hand_drop_finished() -> void:
	pass
