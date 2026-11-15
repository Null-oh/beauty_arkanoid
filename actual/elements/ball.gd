extends RigidBody2D

@export var speed : float = 300.0
@export var ramp : StaticBody2D
@onready var start : bool = false

func _ready() -> void:
	if !ramp:
		print("NO RAMP")
	else:
		await get_tree().create_timer(0.3).timeout
		self.global_position = ramp.launch_coords
		print("BALL READY: ", self.global_position)
		print("ON BALL: ", ramp.launch_coords)
	
	self.linear_damp = 0.0
	self.linear_damp_mode = RigidBody2D.DAMP_MODE_REPLACE
	linear_velocity = Vector2.ZERO
	
	set_collision_layer_value(1, true)
	set_collision_mask_value(2, true)

func _integrate_forces(state):
	if start:
		await get_tree().process_frame
		state.transform.origin = ramp.launch_coords
		state.linear_velocity = Vector2.ZERO

func reset():
	self.global_position = ramp.launch_coords
	print("BALL RESET: ", self.global_position)
	self.linear_velocity = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if start:
			linear_velocity = Vector2(-200, -200).normalized() * speed
			start = false
