extends Camera2D


var player : Player

func _process(delta):
	if player == null:
		player = get_node("/root/Globals").player
		return
	global_position = player.global_position
	
