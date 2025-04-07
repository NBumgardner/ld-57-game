class_name Player
extends CharacterBody2D

var input_direction : Vector2 = Vector2.ZERO
var can_move : bool = false
@export var movement_speed : float = 250

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var spawn_point : Vector2 = Vector2.ZERO


func _ready() -> void:
	Events.level_transition_started.connect(_on_level_transition_started)
	Events.level_transition_completed.connect(_on_level_transition_ended)


func _process(_elta: float) -> void:
	pass


func _physics_process(_delta: float) -> void:
	if not(can_move):
		return 
	velocity = input_direction * movement_speed
	
	move_and_slide()


func _input(_event: InputEvent) -> void:
	if can_move:
		input_direction = Input.get_vector("left","right","up","down").normalized()
		if abs(input_direction.x) > 0.1:
			sprite.flip_h = bool(input_direction.x > 0)


func _on_level_transition_started() -> void:
	self.hide()
	can_move = false
	input_direction = Vector2.ZERO
	set_deferred("process_mode", PROCESS_MODE_DISABLED)


func _on_level_transition_ended() -> void:
	var spawn : Node2D = get_tree().get_first_node_in_group("player_spawn_point")
	if spawn: 
		spawn_point = spawn.global_position
	else: 
		spawn_point = self.global_position
	self.global_position = spawn_point
	
	set_deferred("process_mode", PROCESS_MODE_INHERIT)
	self.show()
	can_move = true
