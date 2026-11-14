extends RigidBody2D

@export var speed : float = 300.0
@export var ramp : StaticBody2D
@onready var start : bool = true

func _ready() -> void:
	if !ramp:
		print("NO RAMP")
	else:
		await get_tree().create_timer(0.1).timeout
		self.global_position = ramp.launch_coords
	
	self.linear_damp = 0.0
	self.linear_damp_mode = RigidBody2D.DAMP_MODE_REPLACE
	linear_velocity = Vector2.ZERO
	
	set_collision_layer_value(1, true)
	set_collision_mask_value(2, true)

func _integrate_forces(state):
	if start:
		state.transform.origin = ramp.launch_coords
		state.linear_velocity = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if start:
			linear_velocity = Vector2(-200, -200).normalized() * speed
			start = false
