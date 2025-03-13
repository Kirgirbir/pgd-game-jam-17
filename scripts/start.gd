extends Button

@onready var menu_root = $"../../..".get_parent()

func _on_pressed() -> void:
	menu_root.queue_free()
