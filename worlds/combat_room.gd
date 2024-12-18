extends Node2D

export var soal: Array = ["+1", "+1"]
var skor = 0

func _ready():
	var jawaban = Math.kalkulasi(soal)
	HUD.set_objective(str(jawaban))
	HUD.set_score(str(skor))
