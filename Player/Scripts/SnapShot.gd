extends Node
class_name  SanpShot

func reset_to_snapshot(player: PlayerNode):
	print('DBG: ', player.sanpshot)
	player.chapters.clear()
	player.chapters.assign(player.sanpshot.chapters as Array[String])
	player.energy_shots = player.sanpshot.energy_shots as int
	player.vine_shots = player.sanpshot.vine_shots as int

func update_snapshot(player: PlayerNode):
	print('UPDATING CHECKPOINT ', player.sanpshot)
	player.sanpshot = {
		"chapters": player.chapters,
		"energy_shots": player.energy_shots,
		"vine_shots": player.vine_shots,
	}
