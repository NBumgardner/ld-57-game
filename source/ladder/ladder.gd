extends Node2D


func _ready() -> void:
	pass


func _process(_elta: float) -> void:
	pass


func _on_body_entered(body):
	print_debug("Ladder overlap detected for body:", body)


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print_debug("Ladder overlap detected for body shape:", body_rid, body, body_shape_index, local_shape_index)


func _on_area_entered(area):
	print_debug("Ladder overlap detected for area:", area)


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print_debug("Ladder overlap detected for area shape:", area_rid, area, area_shape_index, local_shape_index)
