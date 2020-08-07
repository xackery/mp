extends Spatial

export var nav_path: NodePath

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			var space = get_world().direct_space_state
			var camera = get_viewport().get_camera()
			var from = camera.project_ray_origin(event.position)
			var to = from + camera.project_ray_normal(event.position) * 1000
			var hit = space.intersect_ray(from, to)
			if hit.empty():
				return
			get_node(nav_path).destination = hit.position
