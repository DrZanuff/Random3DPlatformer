extends Marker3D


@onready var player : Player = get_parent().get_parent().get_parent()

func _process(delta):
	if player.is_on_floor() and !is_player_moving_on_ground():
		play_animation("idle")
	
	if player.is_on_floor() and is_player_moving_on_ground():
		play_animation("walk")
	
	if !player.is_on_floor() and !player.is_fly_mode():
		play_animation("air")
		
	if !player.is_on_floor() and player.is_fly_mode():
		play_animation("idle")

func play_animation(anim_name):
	if $AnimationWeapons.current_animation != anim_name:
		$AnimationWeapons.play(anim_name,0.2)

func is_player_moving_on_ground() -> bool:
	var velocity_vector = player.velocity
	if abs(velocity_vector.x) + abs(velocity_vector.z)  > 0.2:
		return true
	
	return false
