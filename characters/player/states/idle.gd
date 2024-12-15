extends PawState

onready var bullet = preload("res://instances/bullet/bullet.tscn")

func _physics_process(delta):
	move_controller()
	shoot_controller()

func move_controller():
	var vector = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	if vector: owner.velocity_static = vector
	
	owner.velocity = lerp(owner.velocity, vector * (owner.speed * 10), 0.2)
	owner.move_and_slide(owner.velocity)


func shoot_controller():
	var center_offset = (get_viewport().get_mouse_position() - get_viewport().size / 2)
	owner.get_node("Camera2D").offset = lerp(owner.get_node("Camera2D").offset, center_offset / 20, 0.1)
	
	if Input.is_action_just_pressed("p_action"):
		var bullet_ins = bullet.instance()
		bullet_ins.velocity = center_offset.normalized()
		get_tree().root.get_node("World").add_child(bullet_ins)
		bullet_ins.global_position = owner.global_position
