extends Camera2D
@onready var character_body_2d: CharacterBody2D = $".."
@onready var camera_2d: Camera2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(camera_2d.limit_left < character_body_2d.position.x - 200): 
		camera_2d.limit_left = character_body_2d.position.x - 200
	pass
