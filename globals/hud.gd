extends CanvasLayer

var cursor_arrow = preload("res://assets/textures/cursor_arrow.png")
var cursor_grab = preload("res://assets/textures/cursor_grab.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor_arrow, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(cursor_grab, Input.CURSOR_DRAG)

func set_objective(message: String):
	$M/ObjectiveLabel.percent_visible = 0
	$M/ObjectiveLabel.text = "Skor akhir : " + message
	create_tween().tween_property($M/ObjectiveLabel, "percent_visible", 1, 0.5)

func set_score(message: String):
	$M/ScoreLabel.text = message
