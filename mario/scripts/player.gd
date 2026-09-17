extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy_check: RayCast2D = $RayCast2D
var score = 0

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	
	# Handle jump.
	if Input.is_action_just_pressed("b") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	var running = 2
	if Input.is_action_pressed("a"):
		running = 1
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED / running, 16)
		animated_sprite_2d.flip_h = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, 7)
		
	if enemy_check.is_colliding():
		var enemy = enemy_check.get_collider()
		if enemy:
			if enemy.get_class() == "CharacterBody2D":
				velocity.y = -100
				score += 100
				enemy.die()
		
		
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
