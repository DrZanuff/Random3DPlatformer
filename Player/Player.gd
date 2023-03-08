extends Player
class_name PlayerNode

var can_move := true
@export var start_position := Vector3()
@export var chapters : Array[String] = ['default']
@onready var DoubleJumpNode : DoubleJump3D = get_node("Double Jump 3D")
@onready var DashNode : Dash3D = get_node("Dash 3D")
@onready var ClimbNode : Climb3D = get_node("Climb 3D")

var npc_dialog_callback := func(state:bool):
	pass

var is_climbing = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	setup()
	emerged.connect(_on_controller_emerged.bind())
	submerged.connect(_on_controller_subemerged.bind())


func _physics_process(delta):
	var is_valid_input := Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED

	if is_valid_input and can_move:
		DoubleJumpNode.check_apply_double_jump(input_jump_action_name)
		DashNode.check_apply_dash(input_dash_action_name)
		
#		Climb Mode using FlyMode
		fly_ability.set_active(ClimbNode.is_climbing)
		var input_axis = Input.get_vector(input_back_action_name, input_forward_action_name, input_left_action_name, input_right_action_name)
		var input_jump = Input.is_action_just_pressed(input_jump_action_name)
		var input_crouch = Input.is_action_pressed(input_crouch_action_name)
		var input_sprint = Input.is_action_pressed(input_sprint_action_name)
		var input_swim_down = Input.is_action_pressed(input_crouch_action_name)
		var input_swim_up = Input.is_action_pressed(input_jump_action_name)
		move(delta, input_axis, input_jump, input_crouch, input_sprint, input_swim_down, input_swim_up)
	else:
		# NOTE: It is important to always call move() even if we have no inputs 
		## to process, as we still need to calculate gravity and collisions.
		move(delta)
	


func _input(event: InputEvent) -> void:
	# Mouse look (only if the mouse is captured).
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_head(event.relative)
	
	if Input.is_action_just_pressed("interact"):
		npc_dialog_callback.call(freeze_movement)
		display_interact(false)


func _on_controller_emerged():
	camera.environment = null

func _on_controller_subemerged():
	camera.environment = underwater_env

func toogle_climb_mode(state:bool):
	ClimbNode.set_climbing(state)
	is_climbing = state

func set_start_position(pos : Vector3):
	start_position = pos

func restart_level():
	velocity = Vector3()
	global_position = start_position
	freeze_movement(false)
	
func freeze_movement(state:bool):
	can_move = !state

func display_interact(state:bool):
	$UI/Interact.visible = state

func set_npc_callback(callback: Callable):
	npc_dialog_callback = callback
