extends Node2D

onready var answer_label = $Answer/C/VB/TrueAnswer
onready var current_answer_label = $Answer/C/VB/CurrentAnswer

var soal: PoolStringArray
var jawaban: String

func init(soal: PoolStringArray):
	self.soal = soal
	self.jawaban = soal[-1]
	self.soal.resize(soal.size() - 1)
	
	$EnterArea.connect("body_entered", $Enemies, "generate_enemies", [$EnterArea])
	$DestructTimer.connect("timeout", self, "destruct")
	
	return self

func generate_lock(pos: Vector2):
	$Answer.position = pos * 600
	
	var isX = pos.x != 0
	var selected = Vector2()
	
	for i in [-4, 3]:
		selected = Vector2(pos.x * 10, i) if isX else Vector2(i, pos.y * 10)
		
		var torch = preload("res://scenes/torch.tscn")
		torch = torch.instance()
		torch.global_position = $Lock.to_global($Lock.map_to_world(selected))
		add_child(torch)
	
	for i in range(-3, 3):
		selected = Vector2(pos.x * 10, i) if isX else Vector2(i, pos.y * 10)
		
		$Lock.set_cellv(selected, 0)
	
	$Lock.update_bitmask_region()

func destruct():
	for i in get_children():
		if not i is Light2D:
			i.queue_free()
