extends Node3D

@export_enum("left","right") var dir : String = "left"
@export var speed : int = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dir == "left":
		$Rot.rotate_y(delta * speed)
	
	if dir == "right":
		$Rot.rotate_y(delta * -speed)
