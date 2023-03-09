extends Node3D

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_restarter_body_entered(body):
	if body.is_in_group("Player"):
		var player = body as PlayerNode
		player.restart_level()
		get_tree().call_group('Collectible','reset')
