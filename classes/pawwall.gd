extends TileMap
class_name PawWall

var wall = preload("res://scenes/wall.tscn")

func replace():
	for i in get_used_cells():
		var ii = map_to_world(Vector2(i.x, i.y))
		var wall_ins = wall.instance()
		wall_ins.global_position = ii
		add_child(wall_ins)
	
	clear()
