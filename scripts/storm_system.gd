extends Node

signal storm_started

@export var storm_original_wait_time = 10

var is_storm = false
var time_until_storm  # Tiempo inicial en segundos
var flash_duration = 0.1
var flash_intensity = 1.5
var flash_interval = 8.0 # Intervalo entre relámpagos
var time_since_flash = 0.0
var time_since_last_flash = 0.0

@onready var timer_label = $StormCanvas/TimerLabel
@onready var progress_bar = $StormCanvas/TimerProgressBar
@onready var storm_timer = $StormTimer
@onready var color_rect = $StormCanvas/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.set_visible(true)
	color_rect.material.set_shader_parameter("flash_duration", flash_duration)
	color_rect.material.set_shader_parameter("flash_intensity", flash_intensity)
	color_rect.visible = false
	storm_timer.set_wait_time(storm_original_wait_time)
	storm_timer.start()
	update_timer_label()
	progress_bar.max_value = storm_timer.get_wait_time()
	progress_bar.value = storm_timer.get_wait_time()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_storm:
		time_until_storm = storm_timer.get_time_left()
		if time_until_storm <= 0:
			time_until_storm = 0
			is_storm = true
			storm_started.emit()
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

			
func update_timer_label():
	var total_seconds = max(storm_timer.get_time_left(), 0.0)
	var minutes = int(storm_timer.get_time_left() / 60.0)
	var seconds = int(total_seconds - (minutes * 60.0))
	timer_label.text = "Time until storm: %02d:%02d" % [minutes, seconds]
	
func set_is_istorm(value):
	is_storm = value


func delay_storm():
	print('dalay_storm')
	var wait_time = storm_timer.get_wait_time()
	#Retrasa el temporizador
	storm_timer.stop()
	storm_timer.start(storm_original_wait_time)
	
	
func advance_storm(time):
	var time_left = storm_timer.get_time_left()
	storm_timer.stop()
	if time_left > time:
		storm_timer.start(time_left-time)
