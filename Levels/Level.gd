extends Node

var enemies : Array
@export var level_index : int

func _on_player_player_death():
	get_node("/root/Globals").display_death_screen()
	
	
func _input(event):
	if event.is_action_pressed('start'):
		get_node("/root/Globals").display_pause_screen()
	
func register(enemy):
	enemies.append(enemy)
	

func _process(delta):
	for enemy in enemies:
		if enemy == null:
			enemies.erase(enemy)
	if enemies.size() == 0:
		get_node("/root/Globals").display_victory_screen(level_index)
