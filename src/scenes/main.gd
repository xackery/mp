extends Control

export var active_scene: NodePath

func _ready():
	var screen_size = OS.get_screen_size() - Vector2(0, 64)
	OS.window_size.y = screen_size.y * 0.9
	OS.window_size.x = OS.window_size.y * 4/3
	OS.window_position = screen_size / 2 - OS.window_size / 2

func _input(event):
	$Viewport.input(event)
