extends Node3D
class_name DoubleJump3D

@onready var player : Player = get_parent()
@export_group("Double Jump")
@export var double_jumps : int = 0
var current_double_jumps : int = 0
@export var double_jump_power : float = 3.0

func check_apply_double_jump(input_jump_action_name : String):
	if Input.is_action_just_pressed(input_jump_action_name) and !player.is_on_floor():
		if current_double_jumps < double_jumps:
			player.velocity.y = double_jump_power
			current_double_jumps += 1

	if player.is_on_floor():
		current_double_jumps = 0
