extends Node2D

onready var cursor = $Cursor
onready var map = $TileMap
onready var grid = $Grid

func _ready():
	pass # Replace with function body.

func _process(delta):
	var cell_pos = map.world_to_map(get_global_mouse_position())
	var cell_index = map.get_cellv(cell_pos)
	match cell_index:
		-1:
			cursor.visible = false
		_:
			cursor.visible = true
			cursor.position = map.map_to_world(cell_pos, true)

func _unhandled_input(event):
	if event is InputEventMouseButton and cursor.visible:
		if event.button_index == BUTTON_LEFT:
			set_item()

func set_item():
	var building = $Control/PanelContainer/ItemList.get_selected_item()
	if building != null:
		grid.request_build(building.instance(), get_global_mouse_position())
