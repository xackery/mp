extends Spatial

export var ai_nav_path: NodePath
export var patrol_path: NodePath
export var starting_point := 1

var nav: AINav
var patrol: Path
var point: int

func setup():
	nav = get_node(ai_nav_path)
	patrol = get_node(patrol_path)
	point = starting_point
	nav.connect("destination_reached", self, "_on_destination_reached")

func tick():
	pass

func _on_destination_reached():
	pass #point = (point + 1) % patrol.
