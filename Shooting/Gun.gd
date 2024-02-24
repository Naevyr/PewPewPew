class_name Gun
extends Node2D


@export var projectile : PackedScene
@export var bomb : PackedScene
@export var direction : Vector2 = Vector2.UP

@export var bomb_knockup : float = 10

enum ProjectileType
{
	BOMB,
	PROJECTILE
}
func _ready():
	$Charger.pitch_scale = 0.65

func _input(event):
	
	if event.is_action_pressed("up"):
		rotation_degrees = 0
		direction = Vector2.UP
	if event.is_action_pressed("down"):
		rotation_degrees = 180
		direction = Vector2.DOWN
	if event.is_action_pressed("left"):
		rotation_degrees = -90
		direction = Vector2.LEFT
	if event.is_action_pressed("right"):
		rotation_degrees = 90
		direction = Vector2.RIGHT
	if event.is_action_pressed("A"):
		shoot(ProjectileType.PROJECTILE)
	if event.is_action_pressed("B"):
		shoot(ProjectileType.BOMB)



func shoot(type):
	if get_parent().charge == 0:
		return
	get_parent().charge -= 1
	var scene : PackedScene
	if(type == ProjectileType.PROJECTILE):
		$ProjectileSound.play()
		scene = projectile
	
	elif (type == ProjectileType.BOMB):
		$BombSound.play()
		get_parent().velocity -= bomb_knockup * direction
		scene = bomb
	
	
	var instance = scene.instantiate()
	instance.global_position = get_parent().global_position
	instance.rotation_degrees = rotation_degrees - 90
	instance.direction = direction
	if type == ProjectileType.PROJECTILE:
		(instance as Area2D).set_collision_mask_value(2,true)
		(instance as Area2D).set_collision_layer_value(5,false)
		(instance as Area2D).set_collision_layer_value(6,true)
	get_parent().get_parent().add_child(instance)
	



func _on_area_2d_area_entered(area):

	if area is Projectile and not get_parent().invincibility_frame:
		var player = get_parent()
		$Charger.play()
		player.charge += area.charge 
		player.charge = min(player.max_charge,player.charge)
		area.queue_free()
	
	
