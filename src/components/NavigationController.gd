extends Spatial

export var nav_path: NodePath
export var destination_point: Vector3

var nav: Navigation

func _ready():
	nav = get_node(nav_path)

func _process(delta):
	pass
