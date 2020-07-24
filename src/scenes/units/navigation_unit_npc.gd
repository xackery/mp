extends Spatial

onready var destination := translation

const SPEED = 10.0
const MAX_RAY = 1000.0

var path := []
var nav: Navigation

var from := Vector3()
var to := Vector3()
var project := false

onready var effect = preload("res://effects/spark.tscn")

func _ready():
	var map = self
	while map != get_node('/root') and not map.is_in_group("map"):
		map = map.get_parent()
	
	if map == get_node('/root'):
		print("no map")
		set_process(false)
		return
	
	nav = map.get_node("Navigation")
	
	if nav == null:
		print("no nav")
		set_process(false)
		return

func _process(delta):
	if translation.distance_to(destination) < SPEED * delta * 2:
		return
	
	if path.empty():
		path = nav.get_simple_path(translation, destination, true)
		if not path.empty():
			destination = path[path.size() - 1]
	
	if translation.distance_to(path[0]) < SPEED * delta * 2:
		path.pop_front()
	
	if path.size() > 0:
		translation += translation.direction_to(path[0]) * SPEED * delta

func _physics_process(_delta):
	if project:
		project = false
		var space_state = get_world().direct_space_state
		var ray = space_state.intersect_ray(from, to)
		if not ray.empty():
			destination = ray.position
			var spark = effect.instance()
			spark.translation = destination
			nav.add_child(spark)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var camera = get_viewport().get_camera()
		from = camera.project_ray_origin(event.position)
		to = from + camera.project_ray_normal(event.position) * MAX_RAY
		project = true
