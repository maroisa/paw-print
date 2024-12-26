extends PawState

signal clicked

var num_held: Node2D

func enter():
	var tw: Tween = player.get_node("Tween")
	var book = player.get_node("Pivot/Sprite")
	tw.interpolate_property(book, "position", Vector2(), -book.get_parent().position, 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tw.interpolate_property(book, "modulate:a", 1, 0, 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tw.start()

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

