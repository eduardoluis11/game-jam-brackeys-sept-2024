extends CharacterBody2D


# Parámetros ajustables
@export var speed = 100.0  # Velocidad de movimiento
@export var move_distance = 200.0  # Distancia que recorrerá de un lado a otro

# Variables internas
var direction = 1  # Dirección inicial: 1 para derecha, -1 para izquierda
var start_position = Vector2()

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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Aquí puedes hacer que el jugador reciba daño o pierda una vida
		print("El jugador ha sido golpeado")
		get_parent().get_node("StormTimer").advance_storm(2)
