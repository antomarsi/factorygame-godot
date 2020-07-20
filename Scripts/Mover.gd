extends Building

onready var ejector : Ejector
onready var acceptor : Acceptor
onready var tweenIn : Tween = $TweenIn
export (int) var speed = 1
var holdItem : Item

signal moved_out

func _ready():
	ejector = $Actions/Ejector
	acceptor = $Actions/Acceptor
	acceptor.connect("item_accepted", self, "on_item_accepted")

func on_item_accepted(item: Item):
	if tweenIn.is_active():
		yield(tweenIn, "tween_completed")
	if holdItem:
		yield(self, "moved_out")
	acceptor.take_item()
	var old_pos = item.global_position
	tweenIn.interpolate_property(
		item,
		"global_position",
		old_pos,
		global_position,
		speed,
		Tween.TRANS_LINEAR)
	tweenIn.start()
	holdItem = item

func _on_TweenIn_tween_completed(object, key):
	yield(ejector.eject_item(object), "completed")
	emit_signal("moved_out")

func destroy():
	if holdItem:
		holdItem.queue_free()
	queue_free()
