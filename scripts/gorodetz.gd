extends Node2D

@export var ball : RigidBody2D
@export var ramp : StaticBody2D

@onready var start: ColorRect = $hud/MarginContainer2/HBoxContainer/MarginContainer2/start
@onready var fail: ColorRect = $hud/MarginContainer2/HBoxContainer/MarginContainer2/fail
@onready var win: ColorRect = $hud/MarginContainer2/HBoxContainer/MarginContainer2/win
@onready var pause: ColorRect = $hud/MarginContainer2/HBoxContainer/MarginContainer2/pause
var pause_ball_coords : Vector2
var pause_ball_velocity : Vector2

@onready var lives: Label = $hud/MarginContainer2/HBoxContainer/lives

signal minus_life
signal won

var all_bricks = [] 

func _ready() -> void:
	Global.lives = 3
	lives.text = str(Global.lives)
	
	ball.start = false
	ramp.start = false
	ball.reset()
	
	start.visible = true
	win.visible = false
	fail.visible = false
	pause.visible = false
	
	minus_life.connect(again)
	
	for i in find_children("*", "RigidBody2D"):
		if i.is_in_group("bricks"):
			all_bricks.append(i)
			i.tree_exited.connect(bricks_changed)
			
	
	
	won.connect(show_win)

func bricks_changed():
	all_bricks = all_bricks.filter(func(brick): return is_instance_valid(brick))
	print("BRICKS CHANGED: ",all_bricks.size())
	if all_bricks.size() == 1:
		won.emit()

func again():
	ball.reset()
	lives.text = str(Global.lives)
	ball.start = true
	ramp.start = true

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Ball":
		if Global.lives > 1:
			Global.lives -= 1
			minus_life.emit()
		elif Global.lives == 1:
			ball.start = false
			ramp.start = false
			fail.visible = true

func show_win():
	ball.linear_velocity = Vector2.ZERO
	ball.start = false
	ramp.start = false
	
	win.visible = true

func _on_begin_pressed() -> void:
	start.visible = false
	ball.start = true
	ramp.start = true


func _on_again_pressed() -> void:
	get_tree().reload_current_scene()


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://actual/scenes/menu.tscn")


func _on_continue_pressed() -> void:
	ramp.start = true
	ball.global_position = pause_ball_coords
	ball.linear_velocity = pause_ball_velocity
	pause.visible = false


func _on_pause_button_pressed() -> void:
	pause_ball_coords = ball.global_position
	pause_ball_velocity = ball.linear_velocity
	ball.linear_velocity = Vector2.ZERO
	ball.start = false
	ramp.start = false
	pause.visible = true
