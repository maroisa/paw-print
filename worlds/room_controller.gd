extends Node

export var rooms: int = 5
export var tilemap_tileset: TileSet
export var lock_tileset: TileSet

var room = preload("res://worlds/room.tscn")

var placed_rooms = []
var vectors = [Vector2(-1, 0), Vector2(1, 0), Vector2(0, -1), Vector2(0, 1)]
var last_vector: Vector2

func init(soal2: Array):
	for soal in soal2:
		generate_rooms(soal)

func generate_rooms(soal: PoolStringArray):
	if !placed_rooms: placed_rooms.append(Vector2())
	
	var room_ins = room.instance()
	add_child(room_ins.init(soal, tilemap_tileset, lock_tileset))
	
	var random_vector = vectors[randi() % 4]
	while random_vector + placed_rooms[-1] in placed_rooms:
		random_vector = vectors[randi() % 4]
	
	room_ins.global_position = placed_rooms[-1] * 2560
	
	room_ins.generate_room()
	room_ins.generate_hallway(random_vector)
	room_ins.generate_lock()
	room_ins.generate_hallway(-last_vector)
	
	last_vector = random_vector
	
	placed_rooms.append(random_vector + placed_rooms[-1])
