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
		player.display_interact(true)
		player.set_npc_callback(start_npc_dialog)
		
func _on_body_exited(body):
	if body.is_in_group("Player"):
		var player = body as PlayerNode
		player.display_interact(false)
		player.set_npc_callback(func(): pass)

func start_npc_dialog(freeze_movement: Callable):
	freeze_movement.call(true)
	var new_dialog = Dialogic.start('Greet')
	add_child(new_dialog)
	Dialogic.timeline_ended.connect(func():
		freeze_movement.call(false)
	)
	
