extends YSort

func _ready():
	$EnterArea.connect("body_entered", self, "on_end")

func on_end(body):
	HUD.deactivate()
	Screen.end()
