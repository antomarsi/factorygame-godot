extends Node

onready var items = preload("res://Entity/Item.tscn")
	
func get_item(type):
	var item = items.instance()
	item.type = type
	return item

func spawn_item(type):
	var item = items.instance()
	item.type = type
	return item
