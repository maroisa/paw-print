extends CanvasLayer

func _ready():
	get_tree().paused = true
	fade_out()

func fade_in():
	$AnimationPlayer.play("black")

func fade_out():
	$AnimationPlayer.play_backwards("black")

func tutor():
	var cfg = ConfigFile.new()
	var err = cfg.load("user://save.cfg")
	
	if err == OK:
		get_tree().paused = false
		return

	cfg.save("user://save.cfg")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("tutorial")
	yield($AnimationPlayer, "animation_finished")
	get_tree().paused = false

func refresh():
	fade_out()
	$DieRect.modulate.a = 0

func die_screen():
	fade_in()
	yield($AnimationPlayer, "animation_finished")
	create_tween().tween_property($DieRect, "modulate:a", 1, 1)
