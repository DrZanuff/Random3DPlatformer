extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var player = body as PlayerNode
		var new_dialog = Dialogic.start('Greet')
		player.freeze_movement()
		add_child(new_dialog)
		Dialogic.timeline_ended.connect(player.unfreeze_movement)
		
