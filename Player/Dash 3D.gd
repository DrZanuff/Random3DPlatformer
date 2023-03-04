extends Node3D
class_name Dash3D

@onready var player : PlayerNode = get_parent()
@export_group("Dash")
@export var dashes : int = 0
var current_dashes : int = 0
@export var dash_power : float = 100
var is_dashing : bool = false

func check_apply_dash(input_jump_action_name : String):
	if Input.is_action_just_pressed(input_jump_action_name) and !is_dashing:
		if current_dashes < dashes:
			var forward = -player.global_transform.basis.z * dash_power
			is_dashing = true
			current_dashes += 1
			player.velocity = forward
			$Timer.start(0.7)
			$DashParticles.emitting = true
	
	if is_dashing:
		var forward = -player.global_transform.basis.z * dash_power
		forward.y = 0
		$DashParticles.gravity = forward
#		player.velocity.y = 0
		player.velocity = forward
	
	if Input.is_action_just_released(input_jump_action_name) and is_dashing:
		is_dashing = false
		player.velocity = player.velocity * 0.2
		$DashParticles.emitting = false
		$Timer.stop()
	
	if player.is_on_floor():
		current_dashes = 0
	
	if player.is_climbing:
		current_dashes = 0

func _on_timer_timeout():
	is_dashing = false
	player.velocity = player.velocity * 0.2
	$DashParticles.emitting = false

