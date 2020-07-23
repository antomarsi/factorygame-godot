extends TileMap

enum CELL_TYPE { BUILDING }
onready var buildings = $Buildings

func _ready():
	for child in buildings.get_children():
		var pos = world_to_map(child.position)
		set_cellv(pos, child.type)
		child.position = get_center_tile(pos)

func get_cell_item(cell, type = CELL_TYPE.BUILDING):
	for node in buildings.get_children():
		if node.type != type:
			continue
		if world_to_map(node.position) == cell:
			return node

func request_build(building, world_pos):
	var pos = world_to_map(world_pos)
	var cell_id = get_cellv(pos)
	match cell_id:
		-1:
			set_cellv(pos, building.type)
			buildings.add_child(building)
			building.position = get_center_tile(pos)
			building.initialize()
		CELL_TYPE.BUILDING:
			var cb = get_cell_item(pos)
			if cb:
				cb.destroy()
			set_cellv(pos, building.type)
			buildings.call_deferred("add_child", building)
			building.position = get_center_tile(pos)
			building.initialize()

func get_center_tile(pos) -> Vector2:
	var new_pos = map_to_world(pos)
	new_pos.y += (cell_size.y/2)
	return new_pos
