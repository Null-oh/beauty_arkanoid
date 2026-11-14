extends StaticBody2D

var disappear_tween : Tween
var playing : bool = false
var textures = []
var sprite : Sprite2D

func _ready():
	self.process_mode = Node.ProcessMode.PROCESS_MODE_ALWAYS
	
	for i in get_children():
		if i is TextureRect:
			textures.append(i)
	
	print(textures)

func _on_area_2d_body_entered(body):
	if body.name == "Ball":
		if playing: 
			return
		playing = true
		
		if disappear_tween:
			disappear_tween.kill()
		
		disappear_tween = create_tween()
		
		for i in textures:
			disappear_tween.parallel().tween_property(i, "self_modulate", Color(0.0, 0.0, 0.0, 0.0), 0.2)
			disappear_tween.parallel().tween_property(i, "scale", Vector2(1.1, 1.1), 0.2)
		
		await get_tree().create_timer(0.21).timeout
		self.queue_free()
