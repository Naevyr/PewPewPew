class_name Projectile
extends Area2D


@export var charge : int = 1
@export var speed : float = 1
@export var direction : Vector2


func _physics_process(delta):
	global_position += direction * speed * delta * 50


func _on_body_entered(body):
	if body is Player or body is Enemy or body is Boss_Node:
		call_deferred("damage",body)
	queue_free()
	


func damage(character):
	character.damage(1)
