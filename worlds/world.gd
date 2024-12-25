extends Node2D

func _ready():
	randomize()
	
	var f = File.new()
	f.open("res://assets/soal.json", File.READ)
	var soal = parse_json(f.get_as_text())
	
	$RoomController.init(soal["0"])
