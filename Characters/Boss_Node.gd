class_name Boss_Node
extends CharacterBody2D


@export var health = 1
@onready var explosion = preload("res://Shooting/Explosion.tscn")


func damage(charge):
	health -= charge
	if health == 0:
		get_node("/root/Globals").spawn_scene(explosion,global_position,Vector2.DOWN)
		queue_free()

