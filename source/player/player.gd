class_name Player
extends CharacterBody2D

enum STATE {IDLE, WALKING}

@export var movement_speed : float = 225
var input_direction : Vector2 = Vector2.ZERO
var current_state : STATE = STATE.IDLE
var can_move : bool = false

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health: HealthComponent = $Health

var spawn_point : Vector2 = Vector2.ZERO


func _ready() -> void:
	self.hide()
	Events.level_transition_started.connect(_on_level_transition_started)
	Events.level_transition_completed.connect(_on_level_transition_ended)
	health.death.connect(_on_death)
	health.health_changed.connect(_on_health_changed)
	health.damage_taken.connect(_on_damage_taken)


func _physics_process(_delta: float) -> void:
	if not(can_move):
		return 
	velocity = input_direction * movement_speed
	
	move_and_slide()


func _input(_event: InputEvent) -> void:
	if can_move:
		input_direction = Input.get_vector("left","right","up","down").normalized()
		
		if abs(input_direction.x) + abs(input_direction.y) < 0.1:
			enter_state(STATE.IDLE)
		else:
			enter_state(STATE.WALKING)
			if abs(input_direction.x) > 0.1:
				sprite.flip_h = bool(input_direction.x < 0)


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


func enter_state(new_state : STATE) -> void:
	if current_state == new_state:
		return
	
	current_state = new_state
	match new_state:
		STATE.IDLE:
			sprite.animation = "idle"
		
		STATE.WALKING:
			sprite.animation = "walking"
		
		_:
			printerr("Attempting to enter invalid state")


#region Health
func _on_health_changed(new_health, new_max_health) -> void:
	Database.health_changed.emit(new_health, new_max_health)


func _on_damage_taken() -> void:
	animation.play("take_damage")


func _on_death() -> void:
	self.hide()
	Events.game_ended.emit()
#endregion Health
