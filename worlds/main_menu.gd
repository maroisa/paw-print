extends CanvasLayer

const world = preload("res://worlds/world.tscn")

func _ready():
	$M/VB/StartButton.connect("pressed", self, "on_play")
	$M/VB/FullScreenButton.connect("toggled", self, "on_fullscreen")
	$M/VB/ExitButton.connect("pressed", self, "on_exit")
	
	$M/VB/FullScreenButton.pressed = OS.window_fullscreen

func on_exit():
	get_tree().quit()

func on_play():
	Screen.fade_in()
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().change_scene_to(world)
	Screen.fade_out()
	Screen.tutor()

func on_fullscreen(button_pressed):
	var message: String
	if button_pressed:
		message = "on"
		OS.window_fullscreen = true
	else:
		message = "off"
		OS.window_fullscreen = false
	
	$M/VB/FullScreenButton.text = "Fullscreen: " + message
