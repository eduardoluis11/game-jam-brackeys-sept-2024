shader_type canvas_item;

uniform float flash_duration : hint_range(0.1, 1.0) = 0.1;  // Reducida para un relámpago más corto
uniform float flash_intensity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    float time = mod(TIME, flash_duration * 2.0);
    float intensity = smoothstep(flash_duration * 0.5, flash_duration * 0.0, time);
    COLOR = vec4(vec3(intensity * flash_intensity), 1.0);
}