class_name Player
extends CharacterBody2D

var input_direction : Vector2 = Vector2.ZERO
@export var movement_speed : float = 250


func _ready() -> void:
	pass


func _process(_elta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	velocity = input_direction * movement_speed
	
	move_and_slide()



func _input(_event: InputEvent) -> void:
	input_direction = Input.get_vector("left","right","up","down").normalized()


func _on_ladder_body_entered(body):
	print_debug("Called method _on_ladder_body_entered with body:", body)
