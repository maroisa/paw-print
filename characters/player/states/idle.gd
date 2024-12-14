extends PawState

func _physics_process(delta):
	var vector = Input.get_vector("p_left", "p_right", "p_up", "p_down")
		
	if vector: owner.velocity_static = vector
	
	owner.velocity = lerp(owner.velocity, vector * (owner.speed * 10), 0.2)
	
	owner.move_and_slide(owner.velocity)
