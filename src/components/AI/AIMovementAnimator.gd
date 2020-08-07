extends Spatial

export var turn_tilt_factor := 0.3
export var turn_tilt_max := 0.5
export var walk_animation_speed := 4.8

var ai: AIController
var body: KinematicBody
var animtree: AnimationTree
var root_transform: Transform

func setup(ai_node):
	ai = ai_node
	body = ai.body
	animtree = body.get_node("./AnimationTree")

func tick(delta):
	root_transform = animtree.get_root_motion_transform()
	_apply_tilt()
	_animate_walk()

func _apply_tilt():
	var body_euler: Vector3 = body.transform.basis.get_euler()
	var desired_euler: Vector3 = ai.desired_facing.basis.get_euler()
	var difference := fmod((body_euler.y - desired_euler.y), PI)
	ai.desired_tilt = clamp(difference * turn_tilt_factor, -turn_tilt_max, turn_tilt_max) * clamp(ai.velocity.length() / ai.base_run_speed * 4, 0, 1)

func _animate_walk():
	animtree["parameters/WalkBlend1D/blend_position"] = ai.velocity.length() / ai.base_run_speed
	animtree["parameters/WalkTimeScale/scale"] = clamp(ai.velocity.length() / walk_animation_speed, 1, 10)
