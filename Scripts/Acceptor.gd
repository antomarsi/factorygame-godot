extends Node2D

class_name Acceptor

signal item_accepted(item)
signal can_accept_item

var item_on_hold = false

func _ready():
	pass # Replace with function body.

func can_accept_item() -> bool:
	return get_child_count() == 0

func set_item(item:Item):
	if item_on_hold:
		yield(self, "can_accept_item")
	item_on_hold = false
	emit_signal("item_accepted", item)

func take_item():
	item_on_hold = false
	emit_signal("can_accept_item")
