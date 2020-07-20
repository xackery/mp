extends QodotEntity

func _ready():
	connect("body_entered", self, "_handle_body_entered")

func _handle_body_entered(body: PhysicsBody) -> void:
	print("Something entered")
	if body is Player and "target" in properties:
		var targets = get_tree().get_nodes_in_group("targets")
		for node in targets:
			if "targetname" in node.properties and node.properties.targetname == properties.target:
				body.translation = node.translation
				if "angle" in node.properties:
					body.get_node("Components/PlayerMovementController").rotation_y = deg2rad(node.properties.angle)
				return
