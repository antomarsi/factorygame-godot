extends Building

enum ORE_TYPE { COPPER, IRON }

onready var ejector = $Actions/Ejector
onready var timer = $Timer

var itemHolds = []
var max_item_hold = 5
var speed = 1
var item_type

func _ready():
	timer.connect("timeout", self, "generate_item")
	timer.autostart = true
	timer.wait_time = speed
	timer.start()
	
func initialize():
	self.item_type = MapManager.get_ore_type_position(position)

func _process(delta):
	if itemHolds.size() > 0:
		var hold = itemHolds.front()
		hold.global_position = ejector.global_position
		hold.visible = true
		yield(ejector.eject_item(hold), "completed" )
		itemHolds.pop_front()

func generate_item():
	if itemHolds.size() < max_item_hold:
		var i = ItemManager.spawn_item(self.item_type)
		i.visible = false
		get_node("../../../Items").add_child(i)
		itemHolds.push_back(i)

func destroy():
	for item in itemHolds:
		item.call_deferred("queue_free")
	call_deferred("queue_free")

func can_place_on_tile(position):
	var oreMap = get_tree().get_node("Main/Ores") as OreMap
	return oreMap.has_ore(position)
