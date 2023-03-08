extends Area3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Pivot/Mesh.rotate_y(5 * delta)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var player = body as PlayerNode
		player.chapters.push_back('lost_coin')
		queue_free()
