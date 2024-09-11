extends Area2D

@onready var storm_timer = get_parent().get_node("StormTimer")
# Cuánto tiempo retrasa la tormenta (en segundos)
@export var delay_time = 5.0

func _on_body_entered(body):
	# Verifica si el personaje tocó el ítem
	if body.is_in_group("player"):
		# Llama a la función que retrasa la tormenta
		storm_timer.delay_storm(delay_time)
		queue_free()  # Elimina el ítem después de recogerlo
	
func delay_storm(time):
	# Llama al sistema de tormenta para retrasar el temporizador
	storm_timer.delay_storm(time)
