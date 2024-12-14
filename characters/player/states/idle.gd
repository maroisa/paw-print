extends PawState

onready var bullet_pivot = owner.get_node("BulletPivot")

func _physics_process(delta):
	var vector = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	if vector: owner.velocity_static = vector
	
	owner.velocity = lerp(owner.velocity, vector * (owner.speed * 10), 0.2)
	owner.move_and_slide(owner.velocity)
	
	var center = get_viewport().get_mouse_position() - get_viewport().size / 2
	owner.get_node("Camera2D").offset = lerp(owner.get_node("Camera2D").offset, center / 20, 0.1)
	bullet_pivot.rotation = center.angle()
	

func _input(event):
	if event.is_action_pressed("p_action"):
		var bullet = preload("res://instances/projectile.tscn").instance()
		
		bullet.velocity = (bullet_pivot.get_node("Node2D").global_position - bullet_pivot.global_position).normalized()
		
		owner.add_child(bullet)
