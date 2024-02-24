extends TextureRect

@export var level : PackedScene
var selected : bool = false
var enabled : bool = false

func _process(delta):
	visible = enabled
	$Selected.visible = selected

func _input(event):
	if ( event.is_action_pressed("A") or event.is_action_pressed('start') ) and selected:
		get_node("/root/Globals").current_level = level
		get_tree().change_scene_to_packed(level)
		
		
