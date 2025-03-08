extends Node2D

@export var stage: int = 1
@export var current_hp: int

@onready var stages = [
	load("res://resources/nodes/stages/stage1.png"),
	load("res://resources/nodes/stages/stage2.png"),
	load("res://resources/nodes/stages/stage3.png")
]
@onready var sprite = $sprite
@onready var timer = $Timer

func apply_stage_texture(stage: int) -> void:
	sprite.texture = stages[stage - 1]
	pass

func grow() -> bool:
	if stage == 3:
		return false
	else:
		stage += 1
		return true
	pass
	
func cut() -> bool:
	if stage == 1:
		return false
	else:
		stage -=1
		return true
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_stage_texture(stage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if grow():
		apply_stage_texture(stage)
	else:
		print("can't grow anymore!")
	
	timer.start()
	pass # Replace with function body.


func _on_sprite_clicked() -> void:
	if cut():
		apply_stage_texture(stage)
	else:
		self.queue_free()
