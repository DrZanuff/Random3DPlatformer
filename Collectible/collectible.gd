extends Area3D
class_name Collectible

var is_collected := false

func _ready():
	add_to_group("Collectible",true)
	
func collect():
	is_collected = true
	hide()

func reset():
	is_collected = false
	show()
	
func destroy():
	if is_collected:
		queue_free()
