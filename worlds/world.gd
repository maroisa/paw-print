extends Node2D

const soal = {
	"0": [
		["+6", "x9", "+6", "+9", "=69"],
		["+6", "-2", ">=4"],
		["+2", "+3", "x3", "=15"],
		["+7", "-3", "x2", "=8"],
	]
}

func _ready():
	$RoomController.init(soal["0"])
