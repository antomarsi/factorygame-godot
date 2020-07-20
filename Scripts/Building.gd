extends Node2D

class_name Building

enum CELL_TYPE { BUILDINGS, ORE_DEPOSIT }
export (CELL_TYPE) var type

func destroy():
	queue_free()


func can_place_on_tile(tile_index):
	return tile_index == -1;
