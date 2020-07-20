extends Building

onready var ejector = $Actions/Ejector
onready var timer = $Timer
var oreDeposit : OreDeposit setget set_ore_deposit
var itemHolds = []
var max_item_hold = 5
var speed = 1
var item : Item

func set_ore_deposit(value):
	oreDeposit = value
	match oreDeposit.ORE_TYPE:
		OreDeposit.ORE_TYPE.COPPER:
			item = ItemManager.get_item(Item.ITEM_TYPE.COPPER)
		OreDeposit.ORE_TYPE.IRON:
			item = ItemManager.get_item(Item.ITEM_TYPE.IRON)

func _ready():
	timer.connect("timeout", self, "generate_item")
	timer.autostart = true
	timer.wait_time = speed
	timer.start()

func _process(delta):
	if itemHolds.size() > 0:
		var hold = itemHolds.front()
		hold.global_position = ejector.global_position
		hold.visible = true
		yield(ejector.eject_item(hold), "completed" )
		itemHolds.pop_front()

func generate_item():
	if itemHolds.size() < max_item_hold:
		var i = item.instance() as Item
		i.visible = false
		get_node("../../../Items").add_child(i)
		itemHolds.push_back(i)

func destroy():
	for item in itemHolds:
		item.call_deferred("queue_free")
	call_deferred("queue_free")

func can_place_on_tile(tile_index):
	return tile_index == CELL_TYPE.ORE_DEPOSIT
