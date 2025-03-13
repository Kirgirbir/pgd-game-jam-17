extends Node2D

@onready var locations: Array = []
signal run_ended

func check_available_position(coords: Vector2) -> bool:
	for location in locations:
		if location == coords:
			return true
	return false

	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("child_exiting_tree", _on_node_child_exiting_tree)
	for node in get_children():
		locations.append(node.global_position)
	pass # Replace with function body.



func _on_child_entered_tree(node: Node) -> void:
	locations.append(node.global_position)
	pass # Replace with function body.


func _on_node_child_exiting_tree(node: Node) -> void:
	locations.erase(node.global_position)
	pass # Replace with function body.
