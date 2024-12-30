extends YSort

var number = preload("res://scenes/number.tscn")



var slime = preload("res://characters/slime/slime.tscn")
var skeleton = preload("res://characters/skeleton/skeleton.tscn")

func generate_enemies(body, area):
	area.get_node("CollisionShape2D").set_deferred("disabled", true)
	get_tree().root.get_node("World/Player").machine.travel("Normal")
	
	var random_vec: Vector2
	
	var enemy_ins: PawCharacter
	
	for i in get_parent().soal:
		if i[0] in ["+", "-"]:
			enemy_ins = slime.instance()
		else: enemy_ins = skeleton.instance()
		random_vec = Vector2(randi() % 1200 - 600, randi() % 1200 - 600)
		call_deferred("add_child", enemy_ins.init(random_vec, i))
		

func refresh():
	for child in get_children():
		if child.active: return
	
	var player = get_tree().root.get_node("World/Player")
	player.machine.travel("Calm")
	
	if !player.machine.state.is_connected("clicked", $"../Numbers", "on_click"):
		player.machine.state.connect("clicked", $"../Numbers", "on_click")
	
	get_parent().answer_label.text = get_parent().jawaban
	get_parent().get_node("GetItemSound").play()
	
	for child in get_children():
		var num_ins = number.instance().init(child.global_position, child.nilai)
		num_ins.get_node("C/M").connect("mouse_entered", $"../Numbers", "on_number_entered", [num_ins])
		num_ins.get_node("C/M").connect("mouse_exited", $"../Numbers", "on_number_exited", [num_ins])
		get_parent().get_node("Numbers").call_deferred("add_child", num_ins)
		child.queue_free()
