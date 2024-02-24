extends Node2D

@export var projectile : PackedScene

@export var shoot_delay : float = 1
var current_delay = 0
func _ready():
	get_node('../../../../').register(self)
	
	
func _process(delta):
	if current_delay <=  shoot_delay:
		current_delay += delta
		
		return
		
		
	
	var instance = projectile.instantiate()
	instance.global_position = global_position
	instance.look_at(instance.global_position + Vector2.DOWN)
	instance.direction = Vector2.DOWN
	(instance as Area2D).set_collision_mask_value(1,true)
	get_node('../../../../').add_child(instance)
	current_delay = 0
