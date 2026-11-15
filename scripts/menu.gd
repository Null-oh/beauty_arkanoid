extends Node2D

@onready var camera: Camera2D = $Camera2D
@export var camera_zoom_min : float = 1.0
@export var camera_zoom_max : float = 0.5

func _process(_delta: float) -> void:
	camera.global_position = get_global_mouse_position()/10

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if camera.zoom <= Vector2(camera_zoom_min, camera_zoom_min):
					camera.zoom += Vector2(0.2, 0.2)
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if camera.zoom >= Vector2(camera_zoom_max, camera_zoom_max):
					camera.zoom -= Vector2(0.2, 0.2)

func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://actual/scenes/gorodetz.tscn")
