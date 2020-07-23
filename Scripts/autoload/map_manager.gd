extends Node

onready var ore_map = get_node("/root/Main/Ores")
onready var building_map = get_node("/root/Main/Grid")
	
func get_ore_type_position(pos: Vector2):
	return ore_map.get_ore_type(pos)
