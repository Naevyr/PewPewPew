class_name  Player
extends CharacterBody2D

signal player_death
@export var max_charge = 7
var charge : int
@export var current_direction : Vector2


var invincibility_frame : bool = false


func _ready():
	get_node("/root/Globals").player = self
	charge = max_charge

func _process(delta):
	if velocity.length() == 0:
		
		var nearest_direction = _check_side_collision()
		$Sprite.look_at(global_position + nearest_direction)
		$Sprite.rotation_degrees -= 90
		
		
		
		return
	var direction = velocity.normalized().round()
	if abs(direction.x) == abs(direction.y):
		direction.y = 0
	$Sprite.look_at(global_position - direction)
	$Sprite.rotation_degrees += 90
	



func _physics_process(delta):

	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = Vector2.ZERO

func damage(hp):
	if invincibility_frame:
		return
	
	invincibility_frame = true
			

	$HealthSound.play()
	charge -= hp
	if charge <= 0:
		emit_signal("player_death")
		return
		
		

	

	for i in range(0,4):
		$Sprite.visible = false
		$Gun.visible = false
		await get_tree().create_timer(0.2).timeout
		$Sprite.visible = true
		$Gun.visible = true
		await get_tree().create_timer(0.2).timeout


	
	invincibility_frame = false
		
func _check_side_collision():
	var nearest_direction = Vector2.DOWN
	var nearest = 1000 
	
	
	var space_state = get_world_2d().direct_space_state
	
	
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2.UP * 50)
	var result = space_state.intersect_ray(query)
	if result.size() > 0:
		var dist =  (result['position'] - global_position).length()
		if dist < nearest:
			nearest_direction = Vector2.UP
			nearest = dist
			
			
	query.to = global_position + Vector2.DOWN * 50
	result = space_state.intersect_ray(query)
	if result.size() > 0:
		var dist =  (result['position'] - global_position).length()
		if dist < nearest:
			nearest_direction = Vector2.DOWN
			nearest = dist
	
	query.to = global_position + Vector2.LEFT * 50
	result = space_state.intersect_ray(query)
	if result.size() > 0:
		var dist =  (result['position'] - global_position).length()
		if dist < nearest:
			nearest_direction = Vector2.LEFT
			nearest = dist
			
	query.to = global_position + Vector2.RIGHT * 50
	result = space_state.intersect_ray(query)
	if result.size() > 0:
		var dist =  (result['position'] - global_position).length()
		if dist < nearest:
			nearest_direction = Vector2.RIGHT
			nearest = dist
	
	return nearest_direction 
