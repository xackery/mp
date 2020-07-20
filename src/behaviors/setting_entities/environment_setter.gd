extends QodotEntity

func update_properties():
	.update_properties()
	if 'environment' in properties:
		get_viewport().get_world().environment = load("res://environments/%s_environment.tres" % properties.environment)
