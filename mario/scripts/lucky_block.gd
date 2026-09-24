extends Area2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var used = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		if used == false:
			if ray_cast_2d.get_collider().get_class() == "CharacterBody2D":
				ray_cast_2d.get_collider().health += 1
				animated_sprite_2d.animation = "used"
	pass
