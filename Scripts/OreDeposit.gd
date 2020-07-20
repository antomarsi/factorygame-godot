tool
extends Node2D

class_name OreDeposit

enum CELL_TYPE { BUILDING, ORE_DEPOSIT }
enum ORE_TYPE { COPPER, IRON }

var type = CELL_TYPE.ORE_DEPOSIT
export (ORE_TYPE) var ore_type setget set_ore_type
export (Item.ITEM_TYPE) var item_type

func set_ore_type(value):
	$Sprite.frame = value
	ore_type = value
