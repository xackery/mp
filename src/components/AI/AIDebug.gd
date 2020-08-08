extends Spatial

export var enabled := false

var geo: ImmediateGeometry
var ai_controller: AIController
var shapes := []

func setup(ai_node):
	geo = $DebugSpace/ImmediateGeometry
	ai_controller = ai_node

func tick(delta):
	if not enabled:
		return
	shapes = []
	for ai in ai_controller.get_children():
		_draw_debug_ai(ai)
	_redraw()

func _draw_debug_ai(ai):
	if ai is AINav:
		_draw_debug_ai_nav(ai)

func _draw_debug_ai_nav(ai: AINav):
	var points := PoolVector3Array([ai.body.translation])
	var colors := PoolColorArray([Color.magenta if ai.direct_nav else Color.lime])
	points.append_array(ai.path)
	var append_colors = PoolColorArray([Color.magenta if ai.direct_nav else Color.lime])
	for _p in range(1, ai.path.size()):
		append_colors.append(Color.white)
	colors.append_array(append_colors)
	if points.size() > 0:
		shapes.append({
			"shape": "line",
			"points": points,
			"colors": colors
		})

func _redraw():
	geo.clear()
	
	for shape in shapes:
		match shape.shape:
			"line":
				geo.begin(Mesh.PRIMITIVE_LINES)
				for i in range(shape.points.size()):
					geo.set_color(shape.colors[i])
					geo.add_vertex(shape.points[i] + Vector3(0, 1, 0))
				geo.end()
