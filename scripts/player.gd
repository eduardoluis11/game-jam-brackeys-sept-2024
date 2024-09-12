extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

""" This makes the player move and jump.

This snippet of GDScript is part of a player character's movement logic in a Godot game, specifically handling the jump action. Let's break it down step by step:

Input Check: This line checks if the player has just pressed the action associated with "accept". In Godot, "accept" is typically mapped to the Enter key or a gamepad's A button by default, but it can be customized in the Input Map settings.

Ground Check: This condition ensures that the jump action is only performed if the player character is currently on the ground. The is_on_floor() method returns true if the character is standing on a surface.

Jump Action: When both conditions are met (the jump button is pressed and the character is on the ground), the vertical component of the character's velocity (velocity.y) is set to JUMP_VELOCITY. This value should be a negative number (e.g., -300) to make the character move upwards, as in most 2D coordinate systems in game development, the y-axis increases downwards.


Explanation:
	extends KinematicBody2D: This script extends the KinematicBody2D class, which is used for 2D physics-based movement.
	var velocity = Vector2(): Initializes the velocity vector.
	const JUMP_VELOCITY = -300: Defines a constant for the jump velocity.
	_physics_process(delta): The main physics loop where movement logic is handled.
	move_and_slide(velocity, Vector2.UP): Moves the character based on the velocity and handles collisions.
	This setup ensures that the player can jump when pressing the "accept" action, but only if they are on the ground.

You can use the AudioStreamPlayer node to play the sound effect. Here's how you can modify the selected snippet to include playing the jump sound.

Add an AudioStreamPlayer node to your scene and load the sound effect.
Reference the AudioStreamPlayer node in your script and play the sound when the player jumps.

This way, every time the player jumps, the sound effect will play.

I want to first play the jumping sound effect, and then make the player jump, so that the sound effect plays first, and then you 
see the player jump.
"""
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
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
