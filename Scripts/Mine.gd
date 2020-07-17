extends Node

onready var ejector = $Actions/Ejector
onready var timer = $Timer
onready var itemsHolder = $Items
export var item : PackedScene
var max_item_hold = 5

func _ready():
	timer.connect("timeout", self, "generate_item")

func _process(delta):
	if itemsHolder.get_child_count() > 0:
		if not ejector.can_eject_item():
			yield(ejector, "item_ejected")
		var hold = itemsHolder.get_child(0)
		itemsHolder.remove_child(hold)
		ejector.eject_item(hold)
		

func generate_item():
	if itemsHolder.get_child_count() < max_item_hold:
		var i = item.instance()
		itemsHolder.add_child(i)
