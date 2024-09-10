extends Node2D
var is_storm = false
var calm_color = Color(1, 1, 1)   # Color del fondo durante la calma
var storm_color = Color(0.2, 0.2, 0.5)  # Color del fondo durante la tormenta
var time_until_storm = 60.0  # Tiempo inicial en segundos

@onready var timer_label = $UI/TimerLabel
@onready var progress_bar = $UI/TimeProgressBar

func _ready():
	$StormTimer.start()
	$Background.modulate = calm_color
	update_timer_label()
	progress_bar.max_value = time_until_storm
	progress_bar.value = time_until_storm

func _process(delta):
	if not is_storm:
		time_until_storm -= delta
		if time_until_storm <= 0:
			time_until_storm = 0
			_on_StormTimer_timeout()
		update_timer_label()
		progress_bar.value = time_until_storm

func _on_StormTimer_timeout():
	is_storm = true
	start_storm()

func start_storm():
	print("¡La tormenta ha comenzado!")
	var tween = get_tree().create_tween()
	tween.tween_property($Background, "modulate", storm_color, 3.0)

func update_timer_label():
	var total_seconds = max(time_until_storm, 0.0)
	var minutes = int(time_until_storm / 60.0)
	var seconds = int(total_seconds - (minutes * 60.0))
	timer_label.text = "Time until storm: %02d:%02d" % [minutes, seconds]
