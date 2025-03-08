extends Node
var GRID_SIZE = 40

func snap(pos:Vector2): 
	return pos.snapped(
	Vector2(
	GRID_SIZE,
	GRID_SIZE)
	)

func local_to_grid(pos:Vector2):
	return snap(pos)/GRID_SIZE

func grid_to_local(pos:Vector2i):
	return pos*GRID_SIZE
