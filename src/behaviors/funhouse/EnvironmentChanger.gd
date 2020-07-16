extends Node

export var environment_file_names = []
export var light_colors = []
export var directional_light_node_path: NodePath

var current_index = -1
var directional_light: DirectionalLight

func _ready():
	directional_light = get_node(directional_light_node_path)

func trigger(body: KinematicBody):
	current_index = (current_index + 1) % environment_file_names.size()
	get_viewport().world.environment = load("res://environments/%s.tres" % environment_file_names[current_index])
	directional_light.light_color = light_colors[current_index]
