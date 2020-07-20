extends Node

onready var items = preload("res://Entity/Item.tscn")
	
func get_item(type):
	var item = items.new()
	item.type = type
	return item
