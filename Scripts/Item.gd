tool
extends Node2D

class_name Item

enum ITEM_TYPE {
	COPPER,
	IRON
}

func _ready():
	$Sprite.frame = type

export (ITEM_TYPE) var type setget set_item_type

func set_item_type(value):
	type = value
