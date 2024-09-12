extends Area2D

@onready var storm_timer = get_parent().get_node("StormTimer")
# Cuánto tiempo retrasa la tormenta (en segundos)
@export var delay_time = 5.0

""" This script should handle when the Player touches the Timer Power-Up, so that the storm is delayed, so that it takes
longer for the storm to occur.
"""

""" This function delays the timer bar that makes the storm to show up when the player touches the timer Power Up.

I will add a Power Up sound effect that plays out when the user touches the Power Up.

In the player.gd file, the AudioStreamPlayer node is added to the scene tree using add_child(audio_player). However,
in the item.gd file, the AudioStreamPlayer node is added to the Area2D node, which might not be part of the active scene
tree when the sound is supposed to play.  Solution: Ensure that the AudioStreamPlayer node is added to the scene tree by
adding it to the root node or a node that is part of the active scene tree.

The queue_free() method is called immediately after playing the sound, which might cause the AudioStreamPlayer node to
be freed before the sound finishes playing.  Solution: Use a one-shot timer to delay the queue_free() call until after
the sound has finished playing.

Solution: Use a one-shot timer to delay the queue_free() call until after the sound has finished playing.
"""
func _on_body_entered(body):
	# Verifica si el personaje tocó el ítem
	if body.is_in_group("player"):

		# Llama a la función que retrasa la tormenta
		storm_timer.delay_storm(delay_time)
		queue_free()  # Elimina el ítem después de recogerlo

        # These lines will play a Power Up sound effect
		var jump_sound = preload("res://assets/sound-effects/Powerup.wav")
		var audio_player = AudioStreamPlayer.new()
		audio_player.stream = jump_sound

		# I need to add "get_tree().root" to play this sound effect
		get_tree().root.add_child(audio_player)
		audio_player.play()	# End of the lines that will play a sound effect when you get the Power Up

		#		# Print a debugging message when you touch the power up
		#		print("Power Up collected by player")
		
	
func delay_storm(time):
	# Llama al sistema de tormenta para retrasar el temporizador
	storm_timer.delay_storm(time)
