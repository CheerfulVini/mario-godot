extends Area2D


# Called when the node enters the scene tree for the first time

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		body.score += 1
		print(body.score)
		self.queue_free()
	
	pass # Replace with function body.
