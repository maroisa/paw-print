extends CanvasLayer

var roll_messages = [
	"Game Designer:\n - Naufal H\n - Alex",
	"Artist:\n - Naufal H",
	"Sound Engineer:\n - Alex",
	"Programmer:\n - Ahmad R"
]


func _ready():
	Screen.fade_out()
	$Tween.interpolate_property($BG, "modulate:a", 0, 1, 1)
	$Tween.start()
	yield(get_tree().create_timer(2), "timeout")
	$Tween.interpolate_property($BG, "modulate", Color(1,1,1), Color(0.5, 0.5, 0.5), 0.5)
	$Tween.start()
	yield($Tween, "tween_completed")
	
	for i in roll_messages:
		$Label.text = i
		$Tween.interpolate_property($Label, "modulate:a", 0, 1, 0.5)
		$Tween.start()
		yield($Tween, "tween_completed")
		
		yield(get_tree().create_timer(1.5), "timeout")
		
		$Tween.interpolate_property($Label, "modulate:a", 1, 0, 0.5)
		$Tween.start()
		yield($Tween, "tween_completed")
	
	Screen.fade_in()
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().change_scene("res://worlds/main_menu.tscn")

#func end():
#	get_tree().paused = true
#	fade_in()
#	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
#	yield(get_tree().create_timer(1), "timeout")
#	create_tween().tween_property($EndingRect, "modulate:a", 1, 1)
#	yield(get_tree().create_timer(3), "timeout")
#	yield(create_tween().tween_property($EndingRect, "modulate:a", 0, 1), "finished")
#	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#	fade_out()
#	get_tree().change_scene("res://worlds/main_menu.tscn")
