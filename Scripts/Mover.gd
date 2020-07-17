extends Node2D

onready var acceptor : Acceptor = $Actions/Acceptor
onready var ejector : Ejector = $Actions/Ejector
onready var itemHolder = $Item
onready var tweenIn : Tween = $TweenIn
onready var tweenOut : Tween = $TweenOut

var moving_item = false

func _ready():
	pass

func _process(delta):
	if itemHolder.get_child_count() == 0:
		move_in()
	else:
		move_out()

func move_out():
	if not ejector.can_eject_item() or tweenOut.is_active():
		return
	var item = itemHolder.get_child(0)
	tweenOut.interpolate_property(item, "global_position", itemHolder.global_position, ejector.global_position, 1,
		Tween.TRANS_LINEAR)
	tweenOut.start()

func move_in():
	if acceptor.canAcceptItem() or tweenIn.is_active():
		return
	tweenIn.interpolate_property( acceptor.getItem(), "global_position", acceptor.global_position, itemHolder.global_position, 1,
	Tween.TRANS_LINEAR)
	tweenIn.start()

func _on_TweenIn_tween_completed(object, key):
	var item = acceptor.take_item()
	itemHolder.add_child(item)


func _on_TweenOut_tween_completed(object, key):
	itemHolder.remove_child(object)
	ejector.eject_item(object)
