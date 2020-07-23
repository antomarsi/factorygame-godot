extends TileMap

class_name OreMap


enum ORE_TYPE { COPPER, IRON }

func _ready():
	pass # Replace with function body.

func has_ore(world_pos: Vector2):
	var pos = world_to_map(world_pos)
	var cell_id = get_cellv(pos)
	return cell_id != -1

func get_ore_type(world_pos: Vector2):
	var pos = world_to_map(world_pos)
	var cell_id = get_cellv(pos)
	if (cell_id == -1):
		return null
	return cell_id
