extends Sprite2D

signal clicked


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var local_pos = to_local(mouse_pos)
		var rect = get_rect()
		if rect.has_point(local_pos):
			clicked.emit()
