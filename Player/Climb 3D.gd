extends Node3D
class_name Climb3D

@onready var player : Player = get_parent()
@export  var climb_enabled := false
@export var climp_up_power : float = 2
@export var climp_down_power : float = 3
var previous_gravity = 0
var local_input_jump_action_name = ""
var previous_acc = 0
var previous_dcc = 0
var previous_air_control = 0

var is_climbing = false

func check_apply_climb(input_jump_action_name : String, input_crouch_action_name : String):
	print(player.acceleration,'/' ,player.acceleration, '/',player.air_control)
	if is_climbing:
		local_input_jump_action_name = input_jump_action_name
		if !Input.is_action_pressed(input_jump_action_name) and \
		!Input.is_action_pressed(input_crouch_action_name):
			player.velocity.y = 0
			
		if Input.is_action_pressed(input_jump_action_name):
			player.velocity.y = climp_up_power

		if Input.is_action_pressed(input_crouch_action_name):
			player.velocity.y = -climp_down_power

func set_climbing(state:bool):
	if climb_enabled == true:
		is_climbing = state
		
		if state == true:
			previous_gravity = player.gravity
			previous_acc = player.acceleration
			previous_dcc = player.deceleration
			previous_air_control = player.air_control
			player.gravity = 0
			player.velocity = Vector3()
			player.acceleration = 50
			player.deceleration = 100
			player.air_control = 4
		if state == false:
			player.gravity = previous_gravity
			player.acceleration = previous_acc
			player.deceleration = previous_dcc
			player.air_control = previous_air_control
			if Input.is_action_pressed(local_input_jump_action_name):
				player.velocity.y = 5

