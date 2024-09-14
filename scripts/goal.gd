extends Area2D

# Función para completar el nivel
func complete_level():
	# Aquí puedes poner la lógica para finalizar el nivel.
	# Por ejemplo, cambiar de escena, mostrar una pantalla de victoria, etc.
	get_tree().change_scene_to_file("res://scenes/placeholder_scene.tscn")  # Cambia esta línea a la ruta de la siguiente escena


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):  # Verifica si el cuerpo que colisiona es el jugador
		print("¡Nivel completado!")
		complete_level()
