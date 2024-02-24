

extends Node2D


@export var enemy_max = 1
@export var distance_to_player = 75
@export var enemy_prefab : PackedScene
var player : Player
var enemies : Array

func _process(delta):

	for enemy in enemies:
		if enemy == null:
			enemies.erase(enemy)
	
	
	if player == null:
		
		player = get_node("/root/Globals").player
		return
	
	
	if global_position.distance_to(player.global_position) > distance_to_player and enemies.size() < enemy_max:
		
		var instance = enemy_prefab.instantiate()
		instance.global_position = global_position
		get_parent().add_child(instance)
		enemies.append(instance)
