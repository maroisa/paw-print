extends Node

func kalkulasi(soal: Array):
	var expr = Expression.new()
	var soal_text = sum_soal(soal)
	
	expr.parse(soal_text)
	return expr.execute()

func sum_soal(soal: Array):
	var soal_text = ""
	
	match soal[0][0]:
		"+":
			soal[0] = soal[0].trim_prefix("+")
		"x":
			soal[0] = "0"
	
	for i in soal:
		soal_text += i
	soal_text = soal_text.replace("x", "*")
	return soal_text
