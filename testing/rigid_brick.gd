extends RigidBody2D
@export var sprite : Sprite2D
var active : bool = false
@export var back : bool = false

func _ready():
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, false)
	
	contact_monitor = true
	max_contacts_reported = 1000
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	#freeze = true
	gravity_scale = 0.0
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	
	if !back:
		if not body_entered.is_connected(_on_body_entered):
			body_entered.connect(_on_body_entered)
	else:
		set_back()
	
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
	active = true

func _on_body_entered(body):
	if !active:
		return
	if body.name == "Ball":
		var tween = create_tween()
		tween.parallel().tween_property(sprite, "self_modulate", Color(0.0, 0.0, 0.0, 0.0), 0.2)
		tween.parallel().tween_property(sprite, "scale", Vector2(1.1, 1.1), 0.2)
		await get_tree().create_timer(0.21).timeout
		self.queue_free()

func set_back():
	var area := Area2D.new()
	area.body_entered.connect(_on_body_entered)
	area.collision_mask = 1
	area.monitoring = true
	
	var collision = find_child("CollisionPolygon2D").duplicate()
	if !collision:
		collision = find_child("CollisionShape2D").duplicate()
	
	add_child(area)
	area.add_child(collision)
