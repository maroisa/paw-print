extends Node

var pool_size: int = 15

var pool: Array = []

func _ready():
	var bullet = preload("res://scenes/bullet.tscn")
	var bullet_ins: Area2D
	
	for i in pool_size:
		bullet_ins = bullet.instance()
		bullet_ins.name = "bllt" + str(i)
		add_child(bullet_ins)
		pool.append(bullet_ins)

func spawn(spawn_position: Vector2, velocity: Vector2):
	var bullet = pool.pop_back()
	bullet.activate(spawn_position, velocity)

func despawn(bullet):
	pool.append(bullet)
