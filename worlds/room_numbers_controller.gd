extends Node

var jawaban: String = "0"
var add_count = 0
var num_entered: Area2D

onready var player = get_tree().root.get_node("World/Player")
var unlock = preload("res://scenes/unlock.tscn")

# Object Control
func on_click():
	if !num_entered: return
	player.machine.state.num_held = num_entered

func on_number_entered(number: Area2D):
	if player.machine.state.num_held: return
	set_cursor(Input.CURSOR_MOVE)
	num_entered = number

func on_number_exited(number: Area2D):
	set_cursor(Input.CURSOR_ARROW)
	num_entered = null

func set_cursor(cursor):
	for i in get_children():
		i.get_node("C/M").mouse_default_cursor_shape = cursor
# End Object Control

# Number handler

func add(val):
	jawaban = str(Math.kalkulasi(jawaban + val))
	get_parent().current_answer_label.text = jawaban
	add_count += 1
	
	var to_eval = jawaban
	if get_parent().jawaban[0] == "=": to_eval += "="
	to_eval += get_parent().jawaban
	
	if Math.kalkulasi(to_eval):
		var lock: TileMap = get_parent().get_node("Lock")
		
		var current_cell = Vector2()
		var isX = false
		
		for i in lock.get_used_cells():
			var unlock_ins = unlock.instance()
			var lock_position = lock.to_global(lock.map_to_world(i))
			
			if current_cell: 
				isX = current_cell.y == i.y
				if !isX:
					if i.y == 2:
						add_child(unlock_ins.init(lock_position, true))
						continue
				
			else: current_cell = i
			
			add_child(unlock_ins.init(lock_position))
		
		lock.queue_free()
		get_parent().answer_label.set("custom_colors/font_color", Color("9ff8ff"))
		get_parent().get_node("DestructTimer").start()
		return
	
	if add_count >= get_child_count():
		for i in get_children(): i.queue_free()
		
		jawaban = "0"
		add_count = 0
		get_parent().current_answer_label.text = ""
		get_parent().get_node("EnterArea/CollisionShape2D").set_deferred("disabled", false)

# End Number handler
