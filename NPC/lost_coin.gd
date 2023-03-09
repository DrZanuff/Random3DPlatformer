extends Collectible

func _process(delta):
	$Pivot/Mesh.rotate_y(5 * delta)

func _on_body_entered(body):
	if body.is_in_group("Player") and !is_collected:
		var player = body as PlayerNode
		player.chapters.push_back('lost_coin')
		collect()
