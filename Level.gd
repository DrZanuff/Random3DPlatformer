extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_restarter_body_entered(body):
	if body.is_in_group("Player"):
		var player = body as PlayerNode
		player.restart_level()
