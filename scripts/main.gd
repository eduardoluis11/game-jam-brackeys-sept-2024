extends Node2D

var is_storm = false
var calm_color = Color(1, 1, 1)   # Color del fondo durante la calma
var storm_color = Color(0.2, 0.2, 0.5)  # Color del fondo durante la tormenta
var time_until_storm  # Tiempo inicial en segundos
var rain_shader = load("res://rain_shader_material.tres")
var flash_duration = 0.1
var flash_intensity = 1.0
var flash_interval = 8.0 # Intervalo entre relámpagos
var time_since_flash = 0.0
var time_since_last_flash = 0.0

@onready var timer_label = $UI/TimerLabel
@onready var progress_bar = $UI/TimerProgressBar
@onready var background = $Background
@onready var color_rect = $CanvasLayer/ColorRect
@onready var storm_timer = $StormTimer

func _ready():
	color_rect.material.set_shader_parameter("flash_duration", flash_duration)
	color_rect.material.set_shader_parameter("flash_intensity", flash_intensity)
	color_rect.visible = false
	$StormTimer.start()
	$Background.modulate = calm_color
	update_timer_label()
	progress_bar.max_value = storm_timer.get_wait_time()
	progress_bar.value = storm_timer.get_wait_time()

func _process(delta):
	if not is_storm:
		time_until_storm = storm_timer.get_time_left()
		if time_until_storm <= 0:
			time_until_storm = 0
			_on_StormTimer_timeout()
		update_timer_label()
		progress_bar.value = time_until_storm
	else:
		time_since_flash += delta
		time_since_last_flash += delta

		# Controlar el parpadeo
		if time_since_flash > flash_duration:
			color_rect.visible = false

		# Controlar la aparición de relámpagos
		if time_since_last_flash > flash_interval:
			color_rect.visible = !color_rect.visible
			time_since_flash = 0.0
			time_since_last_flash = 0.0

func _on_StormTimer_timeout():
	is_storm = true
	start_storm()

func start_storm():
	print("¡La tormenta ha comenzado!")
	var tween = get_tree().create_tween()
	tween.tween_property($Background, "modulate", storm_color, 3.0)
	background.set_material(rain_shader)
	

func update_timer_label():
	var total_seconds = max(storm_timer.get_time_left(), 0.0)
	var minutes = int(storm_timer.get_time_left() / 60.0)
	var seconds = int(total_seconds - (minutes * 60.0))
	timer_label.text = "Time until storm: %02d:%02d" % [minutes, seconds]
