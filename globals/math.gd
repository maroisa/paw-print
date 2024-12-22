extends Node

var expr = Expression.new()

func kalkulasi(soal_text: String):
	soal_text = soal_text.replace("x", "*")
	
	expr.parse(soal_text)
	return expr.execute()
