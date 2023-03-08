extends Area3D

@export var chapters : Array[String]
@export var npc_name : String
var player_chapters : Array[String] = []
# TODO - carregar cena custom @export var npc_node = Scene

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
		player_chapters = player.chapters
		
func _on_body_exited(body):
	if body.is_in_group("Player"):
		var player = body as PlayerNode
		player.display_interact(false)
		player.set_npc_callback(func(): pass)

func start_npc_dialog(freeze_movement: Callable):
	freeze_movement.call(true)
	var new_dialog = Dialogic.start(get_timeline())
	add_child(new_dialog)
	Dialogic.timeline_ended.connect(func():
		freeze_movement.call(false)
	)
	
#	print(Dialogic.timeline_directory)
#	print('DBG:', Dialogic.find_timeline('Greet'))

func find_common_timeline() -> String:
	for p in player_chapters.size():
		var current_player_chapter = player_chapters[-p-1]
		var chapter_index = chapters.rfind(current_player_chapter)
		if chapter_index > -1:
			return chapters[chapter_index]
			
	return ''

func get_timeline() -> String:
	var chapter_name = find_common_timeline()
	
	if Dialogic.find_timeline(name + "_" + chapter_name):
		return name + "_" + chapter_name
	
	if Dialogic.find_timeline(name + '_default'):
		return name + '_default'
	
	return 'Greet'


