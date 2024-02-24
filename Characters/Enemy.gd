class_name Enemy
extends CharacterBody2D

@export var speed : float = 2
@export var health : int = 2
@export var distance_to_player : float = 70
@export var projectile : PackedScene 
@export var shoot_delay : float = 1

var player : Player
var current_shoot_delay : float = 0
var first_frame : bool = true

func _ready():
	get_parent().get_parent().register(self)
	
func _process(delta):
	if player == null:
		player = get_node('/root/Globals').player
		current_shoot_delay = shoot_delay
		return
	
	
	if current_shoot_delay <= 0:
		shoot()
		current_shoot_delay = shoot_delay
		
	current_shoot_delay -= delta

	


func shoot():
	var direction = (player.global_position - global_position).normalized().round()
	if abs(direction.x) == abs(direction.y):
		direction.y = 0
	
	var instance = projectile.instantiate()
	
	instance.global_position = global_position
	instance.look_at(instance.global_position + direction)
	instance.direction = direction
	(instance as Area2D).set_collision_mask_value(1,true)
	get_parent().add_child(instance)
	
	


func damage(damage):
	health -= damage
	if health <= 0:
		queue_free()


#for future movement
func compute_nearest_target():
	if player == null:
		return global_position
	var min_dist : float
	var direction : Vector2
	
	min_dist = check_path_lenght(global_position, player.global_position + Vector2.RIGHT * distance_to_player)
	direction = Vector2.RIGHT
	
	var temp_dist = check_path_lenght(global_position, player.global_position + Vector2.DOWN * distance_to_player)
	
	if temp_dist < min_dist:
		min_dist = temp_dist
		direction = Vector2.DOWN
	
	
	temp_dist = check_path_lenght(global_position, player.global_position + Vector2.LEFT * distance_to_player)
	
	if temp_dist < min_dist:
		min_dist = temp_dist
		direction = Vector2.LEFT
	
	temp_dist = check_path_lenght(global_position, player.global_position + Vector2.UP * distance_to_player)
	
	if temp_dist < min_dist:
		min_dist = temp_dist
		direction = Vector2.UP
	
	
	
	return player.global_position + direction * distance_to_player



func check_path_lenght(from, to):
	var map = $NavigationAgent2D.get_navigation_map()
	var path = NavigationServer2D.map_get_path(map,from, to, false)
	var distance = 0.0
	for step in path:
		distance += step.length()
	return distance
	
	
