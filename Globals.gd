extends Node

@export var player : Player
@export var timescale : float = 1.0
@export var current_level = PackedScene

@export var completed_levels = {
		0: false,
		1: false,
		2: false,
		3: false,
	}


@onready var death_screen  = load("res://Levels/DeathScreen.tscn")
@onready var pause_screen = load("res://Levels/PauseMenu.tscn")
@onready var level_select_screen = load("res://Levels/LevelSelectScreen.tscn")
@onready var victory_screen = load("res://Levels/Victory.tscn")



	


func spawn_scene(scene : PackedScene, position : Vector2, normal : Vector2 = Vector2.ZERO): 
	var instance = scene.instantiate()
	instance.global_position = position
	if normal != Vector2.ZERO:
		instance.look_at(position + normal)
		instance.rotation_degrees -= 90
	call_deferred('add_to_scene',instance)

func add_to_scene(instance):
	get_node('../Node/Node2D').add_child(instance)


func display_pause_screen():
	get_tree().change_scene_to_packed(pause_screen)

func display_death_screen():
	get_tree().change_scene_to_packed(death_screen)
	
func display_victory_screen(index):
	completed_levels[index] = true
	get_tree().change_scene_to_packed(level_select_screen)
	if index == 3:
		get_tree().change_scene_to_packed(victory_screen)
