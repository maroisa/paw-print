extends Node2D

const soal = [
		["+1", "-2", "+3", ">=4"],
		["+9", "+6", "-3", "-4", "=12"],
		["+2", "+3", "x3", "-2", "=15"],
		["+7", "-3", "x2", "+3", "=8"],
		["+20", "/2", "+6", "/4", "=16"]
	]


func _ready():
	HUD.init()
	randomize()
	$RoomController.init(soal)
