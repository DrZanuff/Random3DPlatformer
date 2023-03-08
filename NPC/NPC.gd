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

func find_common_timeline() -> String:
	for p in player_chapters.size():
		var current_player_chapter = player_chapters[-p-1]
		var chapter_index = chapters.rfind(current_player_chapter)
		if chapter_index > -1:
			return chapters[chapter_index]
			
	return ''

func get_timeline() -> String:
	var chapter_name = find_common_timeline()
	
	var named_timeline = npc_name + "_" + chapter_name
	print('DBG: Specific Action ', Dialogic.find_timeline(named_timeline),' - ' ,named_timeline)
	if Dialogic.find_timeline(named_timeline) != '':
		return named_timeline
	
	var default_timeline = npc_name + '_default'
	print('DBG: Default Action ', Dialogic.find_timeline(default_timeline),' - ' ,default_timeline)
	if Dialogic.find_timeline(default_timeline) != '':
		return default_timeline
	
	return 'Greet'


