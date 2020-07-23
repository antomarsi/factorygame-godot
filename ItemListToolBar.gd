tool
extends ItemList

export (Array, PackedScene) var item_array setget set_item_array

func _ready():
	pass

func set_item_array(value):
	item_array = value
	clear()
	for item in value:
		var i = item.instance()
		var sprite : AnimatedSprite = i.get_node("Sprite")
		var texture = sprite.frames.get_frame("default", 0)
		add_item(i.building_name, texture, true)
		i.free()

func get_selected_item():
	var items = get_selected_items()
	if items.size() > 0:
		return item_array[items[0]]
	return null
