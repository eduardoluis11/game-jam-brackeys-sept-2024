extends CharacterBody2D

signal palyer_hited

# Parámetros ajustables
@export var speed = 100.0  # Velocidad de movimiento
@export var move_distance = 200.0  # Distancia que recorrerá de un lado a otro

# Variables internas
var direction = 1  # Dirección inicial: 1 para derecha, -1 para izquierda
var start_position = Vector2()

@onready var sprite = $AnimatedSprite2D

func _ready():
	# Guarda la posición inicial del enemigo
	start_position = position

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Mover al enemigo
	velocity.x = direction * speed
	move_and_slide()
	
	# Cambiar de dirección al llegar al límite
	if abs(position.x - start_position.x) >= move_distance:
		direction *= -1
		
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		# Si colisiona con una pared (podría ser un StaticBody2D o una etiqueta como "Wall")
		var collider = collision.get_collider()
		if collider.is_in_group("walls") or collider.is_in_group("rocks"):
			print("Colisión con muro")
			# Cambia la dirección al lado opuesto (inversión de la dirección x)
			direction *= -1
		
	if direction > 0 and not sprite.is_flipped_h():
		sprite.set_flip_h(true)
	elif direction < 0 and sprite.is_flipped_h():
		sprite.set_flip_h(false)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Aquí puedes hacer que el jugador reciba daño o pierda una vida
		print("El jugador ha sido golpeado")
		palyer_hited.emit()
		#storm_timer.advance_storm(2)
