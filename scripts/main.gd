extends Node2D

var is_storm = false
var calm_color = Color(1, 1, 1)   # Color del fondo durante la calma (blanco)
var storm_color = Color(0.2, 0.2, 0.5)  # Color del fondo durante la tormenta (oscuro)


# Llamado cuando la escena esté lista
func _ready():
	# Iniciar el temporizador automáticamente
	$StormTimer.start()
	$Background.modulate = calm_color
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Signal from StormTimer
func _on_storm_timer_timeout() -> void:
	is_storm = true
	start_storm()
	

# Función para iniciar la tormenta
func start_storm():
	print("¡La tormenta ha comenzado!")
	
	# Crear el Tween dinámicamente
	var tween = get_tree().create_tween()
	
	# Configurar el Tween para que cambie el color del fondo de calma a tormenta
	tween.tween_property($Background, "modulate", storm_color, 3.0)
	
	# Aquí puedes agregar más cambios de propiedades si lo deseas.
