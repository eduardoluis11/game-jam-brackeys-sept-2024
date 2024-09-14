extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -200.0

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("accept") and is_on_floor():

		# These lines will play a jumping sound effect
		var jump_sound = preload("res://assets/sound-effects/Retro Jump Classic 08.wav")
		var audio_player = AudioStreamPlayer.new()
		audio_player.stream = jump_sound
		add_child(audio_player)
		audio_player.play()	# End of the lines that will play a sound effect when you jump

		velocity.y = JUMP_VELOCITY	# This makes you jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction < 0 and not sprite.is_flipped_h():
		sprite.set_flip_h(true)
	elif direction > 0 and sprite.is_flipped_h():
		sprite.set_flip_h(false)
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() and collision.get_collider().is_in_group("rocks"):
			print("Colisión con roca")
			var rock = collision.get_collider()
			
			# Despierta la roca si está durmiendo
			rock.sleeping = false  
			
			# Calcula la dirección del empuje según la posición relativa del personaje y la roca
			var push_direction = (rock.global_position - global_position).normalized()
			
			# Aplica el empuje en la dirección calculada
			rock.apply_central_impulse(push_direction * 100)  # Ajusta la fuerza del empuje si es necesario
