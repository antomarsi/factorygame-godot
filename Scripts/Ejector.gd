extends Node2D

class_name Ejector

signal item_ejected

export (NodePath) var acceptorPath
var acceptor : Acceptor

func _ready():
	if (acceptorPath):
		acceptor = get_node(acceptorPath)

func can_eject_item() -> bool:
	return get_child_count() == 0 and acceptor != null
	
func eject_item(item : Item):
	add_child(item)

func _process(delta):
	if get_child_count() != 0 and acceptor != null:
		if not acceptor.canAcceptItem():
			yield(acceptor, "can_accept_item")
		var item = get_child(0)
		remove_child(item)
		acceptor.setItem(item)
		emit_signal("item_ejected")
