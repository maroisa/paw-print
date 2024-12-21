extends Node

var num_entered: Area2D

onready var player = get_tree().root.get_node("World/Player")

func on_click():
	if !num_entered: return
	
	print("Y")
	player.machine.state.num_held = num_entered

func on_number_entered(number: Area2D):
	if player.machine.state.num_held: return
	set_cursor(Input.CURSOR_DRAG)
	num_entered = number

func on_number_exited(number: Area2D):
	set_cursor(Input.CURSOR_ARROW)
	num_entered = null

func set_cursor(cursor):
	for i in get_children():
		i.get_node("C/Label").mouse_default_cursor_shape = cursor
