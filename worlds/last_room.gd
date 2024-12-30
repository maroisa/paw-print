extends YSort

func _ready():
	$EnterArea.connect("body_entered", self, "on_end")

func on_end(body):
	HUD.deactivate()
	Screen.fade_in()
	get_tree().paused = true
	yield(get_tree().create_timer(1), "timeout")
	get_tree().change_scene("res://worlds/credit.tscn")
