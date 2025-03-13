extends Node
var GRID_SIZE = 40

@export var vine_scene = preload("res://scenes/leaf.tscn")

@export var stages = [
	load("res://resources/nodes/stages/stage1.png"),
	load("res://resources/nodes/stages/stage2.png"),
	load("res://resources/nodes/stages/stage3.png")
]

@export var blosssoms = {
	"core": load("res://resources/nodes/flower-core.png"),
	"camomile": load("res://resources/nodes/camomile.png")
}

@export var resources = {
	"biomass": 0,
	"rose": 0,
	"camomile": 0,
	"hibiscus": 0
}

@export var stats = {
	"grow_speed": 1,
	"bloom_chance": 100
}

@export var prestige = {
	
}


	
@onready var rng = RandomNumberGenerator.new()

enum BLOSSOM {
	CORE,
	ROSE,
	SUNFLOWER,
	CAMOMILE,
	HIBISCUS
}
func chance(success_percentage: int) -> bool:
	var failure_precentage = 100 - success_percentage
	var result_list = [true, false]
	var weight_list = PackedFloat32Array([success_percentage, failure_precentage])
	var result = result_list[rng.rand_weighted(weight_list)]
	return result
