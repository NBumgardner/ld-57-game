extends Control


@onready var floor_count_amount_display = $TopGameStatus/HBoxContainer2/FloorCount


func ready():
	floor_count_amount_display.text = Database.floor_count
