extends Spatial

export(String, FILE, "*.tres") var environment_file setget set_environment_file, get_environment_file

func set_environment_file(file_path):
	$WorldEnvironment.environment = load(environment_file)
	print("Set environment")

func get_environment_file():
	return $WorldEnvironment.environment
