extends Node3D
class_name Climb3D

@onready var player : Player = get_parent()
@export  var climb_enabled := false
var local_input_jump_action_name = ""

var is_climbing = false

func _ready():
	local_input_jump_action_name = player.input_jump_action_name

func set_climbing(state:bool):
	if climb_enabled == true:
		is_climbing = state
		
		if state == false:
			if Input.is_action_pressed(local_input_jump_action_name):
				player.velocity.y = 8

