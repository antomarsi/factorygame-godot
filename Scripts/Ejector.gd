extends Node2D

class_name Ejector

signal item_ejected
signal acceptor_setted

var acceptor : Acceptor setget set_acceptor 

func set_acceptor(_acceptor: Acceptor):
	acceptor = _acceptor
	emit_signal("acceptor_setted")
	
func eject_item(item : Item):
	if not acceptor:
		yield(self, "acceptor_setted")
	if not acceptor.can_accept_item():
		yield(acceptor, "can_accept_item")
	acceptor.set_item(item)
	yield(acceptor, "item_accepted")
	emit_signal("item_ejected")
