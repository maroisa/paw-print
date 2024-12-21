extends Node

var enemy = preload("res://characters/slime/slime.tscn")
var number = preload("res://scenes/number.tscn")

func generate_enemies(body, area):
	area.queue_free()
	
	for i in get_parent().soal:
		var enemy_ins = enemy.instance()
		var random_vec = Vector2(randi() % 1200 - 600, randi() % 1200 - 600)
		call_deferred("add_child", enemy_ins.init(get_parent().global_position + random_vec, i))

func refresh():
	for child in get_children():
		if child.active: return
	
	get_tree().root.get_node("World/Player").machine.travel("Calm")
	get_tree().root.get_node("World/Player").machine.state.connect("clicked", $"../Numbers", "on_click")
	
	for child in get_children():
		var num_ins = number.instance().init(child.global_position, child.nilai)
		num_ins.get_node("C/Label").connect("mouse_entered", $"../Numbers", "on_number_entered", [num_ins])
		num_ins.get_node("C/Label").connect("mouse_exited", $"../Numbers", "on_number_exited", [num_ins])
		
		get_parent().get_node("Numbers").call_deferred("add_child", num_ins)
		child.queue_free()
