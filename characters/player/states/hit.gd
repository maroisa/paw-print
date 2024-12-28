extends PawState

func enter():
	owner.get_node("Sprite").modulate = Color(100, 0, 0)
	yield(get_tree().create_timer(0.05), "timeout")
	owner.get_node("Sprite").modulate = Color(1, 1, 1)
	yield(get_tree().create_timer(0.05), "timeout")
	owner.get_node("Sprite").modulate = Color(100, 0, 0)
	yield(get_tree().create_timer(0.05), "timeout")
	owner.get_node("Sprite").modulate = Color(1, 1, 1)
	machine.travel("Normal")


func update():
	owner.move_and_slide(owner.velocity_static * 100)
