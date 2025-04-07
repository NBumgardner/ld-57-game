class_name CatTrap
extends Area2D

@onready var cat_hand: Sprite2D = $CatHand
@onready var spot_light: Sprite2D = $SpotLight
@onready var animation: AnimationPlayer = $AnimationPlayer

@export var damage : float = 2
@export var trap_ready : bool = true
@export var damage_ready : bool = false:
	set(new_value):
		damage_ready = new_value
		if damage_ready:
			for area in get_overlapping_areas():
				deal_damage(area)


func _ready() -> void:
	body_entered.connect(_on_body_entered_area)
	cat_hand.hide()


func _on_body_entered_area(_body: Node2D) -> void:
	if trap_ready:
		animation.play("drop_hand")


func _on_area_entered(area: Area2D) -> void:
	if damage_ready:
		deal_damage(area)


func deal_damage(damaged_node: Node2D) -> void:
	if damage_ready:
		if damaged_node.has_method("take_damage"):
			damaged_node.take_damage(damage)
