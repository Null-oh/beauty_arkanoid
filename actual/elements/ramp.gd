extends StaticBody2D

@onready var launch: Marker2D = $launch
var launch_coords : Vector2
@onready var start : bool = false

func _process(_delta: float) -> void:
	launch_coords = launch.global_position
	

func _unhandled_input(event: InputEvent) -> void:
	if start:
		if event is InputEventMouseMotion:
			self.global_position.x = get_global_mouse_position().x
