class_name Bomb
extends Node2D

@export var explosion : PackedScene 

@export var speed : float = 1
@export var direction : Vector2




func _physics_process(delta):
	global_position += direction * speed * delta * 25


func _on_body_entered(body):
	get_node("/root/Globals").spawn_scene(explosion, global_position, -direction)
	queue_free()
