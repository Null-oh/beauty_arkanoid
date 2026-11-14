extends StaticBody2D

@onready var launch: Marker2D = $launch
var launch_coords : Vector2
@onready var start : bool = true

func _process(delta: float) -> void:
	launch_coords = launch.global_position

func _unhandled_input(event: InputEvent) -> void:
	if start:
		if event is InputEventMouseMotion:
			#self.global_position.x = event.position.x 
			self.global_position.x = get_global_mouse_position().x
			#- 0.5 * get_viewport().get_visible_rect().size.x


#func _unhandled_input(event: InputEvent) -> void:
	#if start:
		#if event is InputEventMouseMotion:
			#self.global_position.x = get_global_mouse_position().x
