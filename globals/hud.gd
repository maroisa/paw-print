extends CanvasLayer

var cursor_cross = preload("res://assets/cursor_cross.png")
var cursor_move = preload("res://assets/cursor_move.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor_cross, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(cursor_move, Input.CURSOR_MOVE)
