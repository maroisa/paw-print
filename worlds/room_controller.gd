extends Node

var room = preload("res://worlds/room.tscn")
var number = preload("res://scenes/number.tscn")

var vectors = [Vector2(-1, 0), Vector2(1, 0), Vector2(0, -1), Vector2(0, 1)]
var placed_room = []
var last_vector = Vector2()

func _ready():
	randomize()
	
	for i in Math.soal["0"].size():
		add_room(i)

func add_room(index: int):
	if !placed_room: placed_room.append(Vector2())
	
	var room_ins = room.instance()
	add_child(room_ins)
	
	room_ins.generate_room()
	
	var random = vectors[randi() % 4]
	
	while random + placed_room[-1] in placed_room:
		random = vectors[randi() % 4]
	
	room_ins.global_position = placed_room[-1] * 1280
	
	room_ins.generate_door(random)
	room_ins.generate_lock()
	room_ins.generate_door(-last_vector)
	
	last_vector = random
	placed_room.append(random + placed_room[-1])
	
	for ii in Math.soal["0"][index]:
		var number_ins = number.instance()
		randomize()
		var random_position = Vector2(randi() % 10 - 5, randi() % 10 - 5) * 20
		number_ins.nilai = ii
		number_ins.global_position = room_ins.global_position + random_position
		room_ins.get_node("Numbers").add_child(number_ins)
