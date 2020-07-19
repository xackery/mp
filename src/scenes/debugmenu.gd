extends VBoxContainer

var map_files := []

func _ready():
	print("DEBUG MENU")
	iterate_dir("res://maps")
	print("Available Maps:")
	for map in map_files:
		print(map)
		var button = Button.new()
		button.text = map
		button.connect("pressed", self, "load_map", [map])
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		$ScrollContainer/VBoxContainer.add_child(button)


func iterate_dir(path: String) -> void:
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name != "." and file_name != ".." and file_name != "autosave":
				if dir.current_is_dir():
					iterate_dir("%s/%s" % [path, file_name])
				elif file_name.ends_with(".map"):
					map_files.push_back("%s/%s" % [path, file_name])
			file_name = dir.get_next()
	else:
		print("Error accessing path %s" % path)

func load_map(path: String) -> void:
	var file = File.new()
	if file.open(path, File.READ) == OK:
		path = file.get_path_absolute()
	print("Loading map %s..." % path)
	var map := preload("res://scenes/map.tscn").instance()
	map.environment_file = "res://environments/forest_environment.tres"
	var qodot_map = map.get_node("QodotMap")
	qodot_map.connect("build_complete", self, "_on_build_complete", [map])
	qodot_map.connect("build_progress", self, "_on_build_progress")
	qodot_map.connect("build_failed", self, "_on_build_failed")
	qodot_map.map_file = path
	map.name = path.get_file().get_basename()
	get_node("/root/main/Viewport").add_child(map)
	get_node("/root/main").active_scene = map.get_path()
	qodot_map.call_deferred("verify_and_build")

func _on_build_complete(map):
	queue_free()

func _on_build_progress(step, progress):
	print("%s: %d%%" % [step, (progress * 100)])

func _on_build_failed():
	print("Build failed")
