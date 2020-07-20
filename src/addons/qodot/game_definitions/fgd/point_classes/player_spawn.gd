extends QodotEntity

var player: Spatial
var spawn_facing := 0.0

func update_properties():
	.update_properties()
	if 'angle' in properties:
		spawn_facing = deg2rad(properties.angle)

func _ready():
	call_deferred("_spawn")

func _spawn():
	player = preload("res://entities/player/player.tscn").instance()
	var active_scene = get_node("/root/main").active_scene
	print(active_scene)
	var scene = get_node("/root/main").get_node(active_scene)
	scene.add_child(player)
	player.owner = scene
	player.get_node("Components/PlayerMovementController").rotation_y = spawn_facing
	player.translation = translation
