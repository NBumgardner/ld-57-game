class_name Level
extends Node2D

@export var player_spawn_point : Node2D
@export var animation : AnimationPlayer
@export var objects: Node2D


func _ready() -> void:
	hide()
	y_sort_enabled = true
	
	if player_spawn_point:
		player_spawn_point.add_to_group("player_spawn_point")
	
	# Runs if 'Run Current Scene(F6)' is selected
	if get_tree().current_scene == self:
		add_debug_tools()


func start_level() -> void:
	show()
	animation.play("level_animations/move_in")
	Events.level_transition_started.emit()


func end_level() -> void:
	animation.play("level_animations/move_out")
	disable_objects()
	if player_spawn_point:
		player_spawn_point.remove_from_group("player_spawn_point")


func enable_objects() -> void:
	objects.set_deferred("process_mode",PROCESS_MODE_INHERIT)


func disable_objects() -> void:
	objects.set_deferred("process_mode",PROCESS_MODE_DISABLED)


func _on_start_level_animation_ended() -> void:
	Events.level_transition_completed.emit()
	enable_objects()


func add_debug_tools() -> void:
	print("testing...")
	var debug_packed_scene : PackedScene = load("uid://c1xjwh3bd8v1o")
	var debug_scene : Node = debug_packed_scene.instantiate()
	add_child(debug_scene)
	start_level()
