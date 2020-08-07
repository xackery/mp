extends Spatial
class_name AINav

signal destination_reached

const CLOSE_ENOUGH = 0.5

export var destination: Vector3 setget _set_destination

var ai: AIController
var body: KinematicBody
var nav: Navigation
var path: PoolVector3Array
var invalidate_destination := true

func setup(ai_node):
	path = PoolVector3Array()
	ai = ai_node
	body = ai.body
	destination = body.translation
	_get_nav()

func tick(delta):
	var run_speed = ai.calc_run_speed()
	
	if body.translation.distance_to(destination) < CLOSE_ENOUGH:
		ai.velocity = Vector3()
		path = PoolVector3Array()
		destination = body.translation
		emit_signal("destination_reached")
		return
	
	if path.empty() or invalidate_destination:
		invalidate_destination = false
		var space = get_world().direct_space_state
		var hit = space.intersect_ray(body.translation, destination, [self])
		
		# Try to find a direct path
		if hit.empty() or hit.position.distance_to(destination) < CLOSE_ENOUGH:
			path = PoolVector3Array([destination])
		else: # No direct path
			path = nav.get_simple_path(translation, destination)
		if not path.empty():
			destination = path[path.size() - 1]
	
	if body.translation.distance_to(path[0]) < CLOSE_ENOUGH:
		path.remove(0)
	
	if path.size() > 0:
		ai.velocity = ai.velocity.linear_interpolate(body.translation.direction_to(path[0]) * clamp(body.translation.distance_to(destination) * ai.acceleration, 0, run_speed), ai.acceleration * delta)

func _get_nav():
	for n in get_tree().get_nodes_in_group("nav"):
		nav = n
		break

func _set_destination(value):
	destination = value
	invalidate_destination = true
