extends Node2D

var calm_color = Color(1, 1, 1)   # Color del fondo durante la calma
var storm_color = Color(0.2, 0.2, 0.5)  # Color del fondo durante la tormenta
var rain_shader = load("res://shaders/rain_shader_material.tres")

@onready var background = $Background
@onready var color_rect = $Flash/ColorRect
@onready var storm_system = $StormSystem

func _ready():
	$Background.modulate = calm_color

func _on_storm_system_storm_started() -> void:
	print("¡La tormenta ha comenzado!")
	var tween = get_tree().create_tween()
	tween.tween_property($Background, "modulate", storm_color, 3.0)
	background.set_material(rain_shader)


func _on_enemy_palyer_hited() -> void:
	storm_system.advance_storm(5)


func _on_item_item_collected() -> void:
	storm_system.delay_storm()
