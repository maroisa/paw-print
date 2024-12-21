extends Node2D

var soal = {
	"0": [
		["+1", "+2", "+3"],
		["+4", "+5", "-3"],
		["+10", "+5", "-9"]
	]
}

func _ready():
	$RoomController.init(soal["0"])
