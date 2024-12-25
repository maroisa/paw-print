extends Node

onready var room = preload("res://worlds/room.tscn")

var vectors: PoolVector2Array = [Vector2(-1, 0), Vector2(1, 0), Vector2(0, -1), Vector2(0, 1)]

var placed_room: PoolVector2Array = [Vector2()]
var last_vector: Vector2

var locked = false

func init(soal: Array):
	randomize()
	
	for i in soal.size() + 1:
		if i == soal.size():
			generate_rooms([])
			return
		
		generate_rooms(soal[i])

func generate_rooms(soal: PoolStringArray):
	var room_ins = room.instance()
	var random_size = Vector2(randi() % 3 + 7, randi() % 3 + 7)
	var random_vector = vectors[randi() % 4]
	
	while placed_room[-1] + random_vector in placed_room:
		random_vector = vectors[randi() % 4]
	
	
	for i in range(-random_size.x, random_size.x):
		i = i + placed_room[-1].x * 20
		for ii in range(-random_size.y, random_size.y):
			ii = ii + placed_room[-1].y * 20
			$TileMap.set_cell(i, ii, 0)
	
	for i in range(-15, 15):
		i = i + placed_room[-1].x * 20
		for ii in range(-15, 15):
			ii = ii + placed_room[-1].y * 20
			if $TileMap.get_cell(i, ii) == -1:
				$TileMap.set_cell(i, ii, 1)
	
	if soal: 
		add_child(room_ins.init(soal))
		
		generate_hallway(random_vector)
		room_ins.generate_lock(random_vector)
	
	generate_hallway(-last_vector)
	
	room_ins.global_position = placed_room[-1] * 2560
	placed_room.append(placed_room[-1] + random_vector)
	last_vector = random_vector
	
	$TileMap.update_bitmask_region()

func generate_hallway(pos: Vector2):
	
	var isX = pos.x != 0
	var selected = Vector2()
	
	var wall_autotile_coord = [Vector2(8, 1), Vector2(9, 3), Vector2(10, 0), Vector2(11, 2)]
	
	for i in 11:
		for ii in range(-3, 3):
			if isX: selected = Vector2(clamp(pos.x * i, -10, 9), ii)
			else: selected = Vector2(ii, clamp(pos.y * i, -10, 9))
			
			$TileMap.set_cellv(selected + placed_room[-1] * 20, 0)
	
	$TileMap.update_bitmask_region()
