extends Area2D
var exploded = false
func _ready():
	$ExplosionSound.play()
	$AnimatedSprite2D.play()
	await $AnimatedSprite2D.animation_finished

	queue_free()


func _physics_process(delta):
	if not exploded:
		call_deferred('explode')
		exploded = true
		
	



func explode():
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if not body is CharacterBody2D:
			continue
		
		var relativePosition = body.global_position - global_position 
			
		(body as CharacterBody2D).velocity += relativePosition.normalized() * 50
