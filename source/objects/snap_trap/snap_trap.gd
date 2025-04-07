extends Area2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var trap_ready : bool = true
var damage : float = 3
@export var damage_ready : bool = false:
	set(new_value):
		damage_ready = new_value
		if damage_ready:
			for area in get_overlapping_areas():
				deal_damage(area)


func _ready() -> void:
	self.body_entered.connect(_on_body_entered_area)
	self.area_entered.connect(_on_area_entered)


func _on_body_entered_area(body : Node2D) -> void:
	if trap_ready and body is Player:
		trap_ready = false
		animation.play("snap")


func _on_area_entered(area: Area2D) -> void:
	if damage_ready:
		deal_damage(area)


func deal_damage(damaged_node: Node2D) -> void:
	if damage_ready:
		if damaged_node.has_method("take_damage"):
			damaged_node.take_damage(damage)
