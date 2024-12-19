extends PawState

var center_offset: Vector2

var number_held: Area2D = null
var number_entered: Area2D = null

var click_double = false

func enter():
	owner.connect("number_entered", self, "on_number_entered")
	owner.connect("number_exited", self, "on_number_exited")

func update():
	move_controller()
	
	if !number_entered:
		return
	
	if Input.is_action_just_pressed("p_action"):
		number_entered.set_cursor(Input.CURSOR_ARROW)
		number_held = number_entered
	
	if !number_held:
		return
	
	item_controller()

func move_controller():
	var vector = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	if vector: owner.velocity_static = vector
	
	owner.velocity = lerp(owner.velocity, vector * (owner.speed * 10), 0.2)
	owner.move_and_slide(owner.velocity)
	
	center_offset = (get_viewport().get_mouse_position() - get_viewport().size / 2)
	owner.get_node("Camera2D").offset = lerp(owner.get_node("Camera2D").offset, center_offset / 10, 0.1)
	owner.get_node("Pivot").position = lerp(owner.get_node("Pivot").position, center_offset.normalized() * 64, 0.25)

func item_controller():
	number_held.global_position = lerp(
		number_held.global_position, 
		owner.get_node("Pivot").global_position, 
		0.2
	)
	
	if Input.is_action_just_pressed("p_action"):
		if click_double:
			number_held.velocity = center_offset.normalized()
			number_held = null
			number_entered = null
		
		click_double = !click_double

func on_number_entered(number):
	if number_held: return
	print(number.name, " entered")
	
	number_entered = number
	number.set_cursor(Input.CURSOR_DRAG)

func on_number_exited():
	if number_held: return
	
	print(number_entered.name, " exited")
	number_entered.set_cursor(Input.CURSOR_ARROW)
	
	number_entered = null
