extends Node2D

class_name Acceptor

signal item_accepted
signal can_accept_item

func _ready():
	pass # Replace with function body.

func canAcceptItem() -> bool:
	return get_child_count() == 0

func setItem(item:Item):
	add_child(item)
	emit_signal("item_accepted")
	
func getItem():
	return get_child(0)

func take_item() -> Item:
	var item = get_child(0)
	remove_child(item)
	emit_signal("can_accept_item")
	return item
