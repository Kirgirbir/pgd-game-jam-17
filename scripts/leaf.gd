extends Node2D

@export var stage: int = 1
@export var hp_per_stage: int = 10
@export var current_time: int = Setup.stats["grow_speed"]
@export var is_core: bool = false

enum BLOSSOM {
	CORE,
	CAMOMILE,
}

@onready var directions = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]
@onready var grid = self.get_parent()
@onready var blossom_type = null
@onready var blossom_states = [BLOSSOM.CAMOMILE]
@onready var sprite = $sprite
@onready var subsprite = $subsprite
@onready var timer = $Timer

func choose_position() -> Vector2:
	var positions = []
	for direction in directions:
		var global_direction = self.global_position + direction*32
		if not(grid.check_available_position(global_direction)):
			positions.append(global_direction)
	if positions.is_empty():
		if self.blossom_type != BLOSSOM.CORE:
			self.grow()
		else:
			Vector2.ZERO
	else:
		return positions.pick_random()
	return Vector2.ZERO

func apply_blossom_texture(state: BLOSSOM) -> bool:
	match state:
		BLOSSOM.CORE:
			subsprite.texture = Setup.blosssoms["core"]
		#BLOSSOM.ROSE:
		#	subsprite.texture = Setup.blosssoms["rose"]
		#BLOSSOM.SUNFLOWER:
			#subsprite.texture = Setup.blosssoms["sunflower"]
		BLOSSOM.CAMOMILE:
			subsprite.texture = Setup.blosssoms["camomile"]
		#BLOSSOM.HIBISCUS:
			#subsprite.texture = Setup.blosssoms["hibiscus"]
		_:
			return false
	return true

func apply_stage_texture(stage: int) -> void:
	if stage == 4:
		apply_blossom_texture(self.blossom_type)
	else:
		sprite.texture = Setup.stages[stage - 1]

func grow() -> bool:
	match stage:
		4: 
			return false
		3:
			if Setup.chance(Setup.stats["bloom_chance"]):
				self.blossom_type = blossom_states.pick_random()
				stage += 1
			return true
		_:
			stage += 1
			return true
	
func cut() -> bool:
	match stage:
		1:
			return false
		4:
			self.blossom_type = null
			stage -= 1
			return true
		_:
			stage -=1
			return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_core:
		stage = 3
		apply_stage_texture(stage)
		self.blossom_type = BLOSSOM.CORE
		apply_blossom_texture(blossom_type)
	timer.start(current_time)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if choose_position() != Vector2.ZERO:
		var new_vine = Setup.vine_scene.instantiate()
		new_vine.global_position = choose_position()
		grid.add_child(new_vine)
	timer.start(current_time)
	self.apply_stage_texture(stage)
	pass # Replace with function body.


func _on_sprite_clicked() -> void:
	if is_core:
		pass
	else:
		if cut():
			apply_stage_texture(stage)
		else:
			self.queue_free()
