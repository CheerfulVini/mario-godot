extends CharacterBody2D

@export var speed: float = 50.0
@export var gravity: float = 900.0

@onready var wall_check: RayCast2D = $RayCast2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D

var direction: int = -1 # -1 para esquerda, 1 para direita

func _physics_process(delta: float) -> void:
	# Aplicar gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Mudar de direção se bater na parede
	if wall_check.is_colliding():
		if wall_check.get_collider().get_class() == "CharacterBody2D":
			wall_check.get_collider().damage()
		else:
			direction *= -1
			wall_check.scale.x *= -1 # Inverte o RayCast para o outro lado

	# Movimento horizontal
	velocity.x = direction * speed
	
	# Atualizar animação e direção do sprite
	animated_sprite.flip_h = (direction > 0)
	
	move_and_slide()

# Função chamada quando o jogador pula em cima do Goomba
func die() -> void:
	speed = 0.0
	self.set_physics_process(false)
	collision_shape2d.disabled = true
	animated_sprite.animation = "dead"
	await get_tree().create_timer(0.5).timeout
	# Tocar animação de morte ou sumir
	queue_free()
