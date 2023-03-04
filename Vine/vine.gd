extends CSGBox3D

func _ready():
	var mesh_size = size
	$VineArea/CollisionShape3D.shape.size = mesh_size
	
func _on_vine_area_body_entered(body):
	if body.is_in_group("Player"):
		var player = body as PlayerNode
		player.toogle_climb_mode(true)


func _on_vine_area_body_exited(body):
	if body.is_in_group("Player"):
		var player = body as PlayerNode
		player.toogle_climb_mode(false)
