extends Spatial

export var base_speed := 6.0
export var max_speed := 100.0
export var acceleration := 16.0
export var deceleration := 32.0
export var gravity := 20.0
export var rotation_speed := 0.1

export var body_node_path: NodePath
export var camera_node_path: NodePath

var body: Spatial
var camera: Camera
var velocity := Vector3()
var mouse_movement := Vector2()
var rotation_x := 0.0
var rotation_y := 0.0

func _ready():
	body = get_node(body_node_path)
	camera = get_node(camera_node_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	rotation_y = body.rotation.y

func _physics_process(delta):
	var input_x := Input.get_action_strength("move_left") - Input.get_action_strength("move_right")
	var input_z := Input.get_action_strength("move_forward") - Input.get_action_strength("move_back")
	
	var horizontal_input := Vector3(input_x, 0, input_z)
	if horizontal_input.length_squared() > 1.0:
		horizontal_input = horizontal_input.normalized()
	
	horizontal_input = horizontal_input.rotated(Vector3.UP, -rotation_y)
	
	var accel = acceleration if horizontal_input.dot(velocity) > 0.0 else deceleration
	
	var horizontal_velocity := velocity * Vector3(1.0, 0.0, 1.0)
	horizontal_velocity = horizontal_velocity.linear_interpolate(horizontal_input * base_speed, accel * delta)
	
	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z
	
	if body.is_on_floor():
		velocity.y = 0
	
	velocity.y -= gravity * delta
	
	velocity = body.move_and_slide(velocity, Vector3.UP)
	
	rotation_y += mouse_movement.x * delta * rotation_speed
	rotation_x += mouse_movement.y * delta * rotation_speed
	
	rotation_y = fmod(rotation_y, 2 * PI)
	rotation_x = clamp(rotation_x, -PI / 2, PI / 2)
	
	body.rotation = Vector3(0.0, -rotation_y, 0.0)
	camera.rotation = Vector3(-rotation_x, 0.0, 0.0)
	
	mouse_movement = Vector2()

func _input(event):
	if event is InputEventMouseMotion:
		mouse_movement += event.relative
