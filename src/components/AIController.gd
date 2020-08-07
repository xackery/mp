extends Spatial
class_name AIController

export var base_run_speed = 16
export var turn_speed = PI
export var velocity := Vector3()
export var acceleration: float = 4
export var gravity: float = 10
export var desired_tilt: float = 0
export var tilt_speed: float = PI/2
export var model_path: NodePath

var body: KinematicBody
var desired_facing: Transform
var model: Spatial

func _ready():
	_get_body()
	model = get_node(model_path)
	if body == null:
		set_process(false)
		return
	for ai in get_children():
		ai.setup(self)

func _process(delta):
	for ai in get_children():
		ai.tick(delta)

func _physics_process(delta):
	#velocity = lerp(velocity, desired_velocity, acceleration * delta)
#	body.transform = body.transform.interpolate_with(body.transform.looking_at(-desired_facing * Vector3(1, 0, 1) + body.translation * Vector3(0, 1, 0), Vector3.UP), turn_speed * delta)
	var move := velocity
	if not body.is_on_floor():
		move += Vector3(0, -gravity, 0)
	if velocity.length_squared() > 0.1:
		var horizontalized_facing = (velocity * Vector3(-1, 0, -1)).normalized()
		if horizontalized_facing.length_squared() > 0:
			desired_facing = body.transform.looking_at(horizontalized_facing + body.translation, Vector3.UP)
	if desired_facing != null:
		body.transform = body.transform.interpolate_with(desired_facing , turn_speed * delta)
		model.transform = model.transform.interpolate_with(Transform().rotated(Vector3.BACK, desired_tilt), tilt_speed * delta)
	velocity = body.move_and_slide_with_snap(move, Vector3(0, -1, 0), Vector3.UP)

func _get_body():
	var node: Node = self
	while not node is KinematicBody and node != get_node('/root'):
		node = node.get_parent()
	if node != get_node('/root'):
		body = node

func calc_run_speed() -> float:
	return base_run_speed
