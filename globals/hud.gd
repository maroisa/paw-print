extends CanvasLayer

var cursor_cross = preload("res://assets/cursor_cross.png")
var cursor_move = preload("res://assets/cursor_move.png")

var player

func activate():
	self.show()
	
	Input.set_custom_mouse_cursor(cursor_cross, Input.CURSOR_ARROW, Vector2(32, 32))
	Input.set_custom_mouse_cursor(cursor_move, Input.CURSOR_MOVE, Vector2(32, 32))
	
	player = get_tree().root.get_node("World/Player")
	$M/Healthbar.max_value = player.health
	
	refresh()

func deactivate():
	player = null
	Input.set_custom_mouse_cursor(null)
	self.hide()

func refresh():
	if player != null:
		$M/Healthbar.value = player.health
