@tool
extends Area3D

@export_enum("CheckPoint", "LevelStart") var type: String = "LevelStart":
	set(new_type):
		type = new_type
		print(new_type)
		if Engine.is_editor_hint():
			if new_type == "CheckPoint":
				$CheckPoint.show()
				$LevelStart.hide()
			else:
				$LevelStart.show()
				$CheckPoint.hide()

var activate := false

func _ready():
	if not Engine.is_editor_hint():
		if type == "CheckPoint":
			$CheckPoint.show()
			$LevelStart.hide()
			$CheckPoint/AnimationPlayer.play("disabled")
		else:
			$LevelStart.show()
			$CheckPoint.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node('%Jewel').rotate_y(1.2 * delta )

func _on_body_entered(body):
	if not Engine.is_editor_hint():
		if body.is_in_group("Player"):
			if type == "CheckPoint":
				var player = body as PlayerNode
				disable_other_check_points()
				player.set_start_position($Spawner.global_position)
				$CheckPoint/AnimationPlayer.play("enabled")
				activate = true
			

func disable_other_check_points():
	get_tree().call_group("CheckPoint", "disable_check_point")
	
func disable_check_point():
	activate = false
	$CheckPoint/AnimationPlayer.play("disabled")
