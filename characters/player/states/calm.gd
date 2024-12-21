extends PawState

signal clicked

var num_held: Node2D

func update():
	get_parent().get_node("Normal").move_controller()
	
	if num_held:
		num_held.global_position = lerp(num_held.global_position, player.get_node("Pivot").global_position, 0.2)
	
	if Input.is_action_just_pressed("p_action"):
		if !num_held:
			emit_signal("clicked")
			return
		
		if num_held:
			num_held.velocity = player.center_offset.normalized()
			num_held = null

