extends Particles

func _ready():
	emitting = true
	$Timer.start(lifetime + 0.5)

func _on_Timer_timeout():
	queue_free()
