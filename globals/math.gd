extends Node

func kalkulasi(soal: Array):
	var expr = Expression.new()
	var soal_text = sum_soal(soal)
	
	expr.parse(soal_text)
	return expr.execute()

func sum_soal(soal: Array):
	var soal_text = "0"
	for i in soal: soal_text += i
	soal_text = soal_text.replace("x", "*")
	return soal_text
