extends Node2D

@onready var vines = $game_layer/vines

func _on_menu_close(node: Node) -> void:
	var core_vine = Setup.vine_scene.instantiate()
	core_vine.is_core = true
	vines.add_child(core_vine)
