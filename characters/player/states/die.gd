extends PawState

func enter():
	owner.get_node("AnimationTree").active = false
	owner.modulate.a = 0.2
	HUD.deactivate()
	Screen.die_screen()
	yield(get_tree().create_timer(3), "timeout")
	get_tree().reload_current_scene()
