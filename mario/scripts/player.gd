extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, 7)
		animated_sprite_2d.flip_h = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, 7)

	move_and_slide()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jump"
	else:
		if (velocity.x > 1 || velocity.x < -1):
			animated_sprite_2d.animation = "run"
			var true_velocity = abs(velocity.x)
			animated_sprite_2d.speed_scale = 1 + (true_velocity / 300)
		else:
			animated_sprite_2d.animation = "idle"
			
	print(velocity.x)
