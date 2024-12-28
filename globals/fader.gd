extends CanvasLayer

func fade_in():
	$AnimationPlayer.play("black")

func fade_out():
	$AnimationPlayer.play_backwards("black")


