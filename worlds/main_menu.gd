extends CanvasLayer

const world = preload("res://worlds/world.tscn")

func _ready():
	$M/VB/StartButton.connect("pressed", self, "on_play")
	$M/VB/ExitButton.connect("pressed", self, "on_exit")

func on_exit():
	get_tree().quit()

func on_play():
	Fader.fade_in()
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().change_scene_to(world)
	Fader.fade_out()
