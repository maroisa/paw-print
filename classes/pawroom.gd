extends Node2D
class_name PawRoom

func generate_room():
	$TileMap.clear()
	$PawWall.clear()
	
	randomize()
	
	var size = [
		randi() % 4 + 6,
		randi() % 4 + 6,
		randi() % 4 + 6,
		randi() % 4 + 6
	]
	
	for i in range(-size[0], size[1]):
		for ii in range(-size[2], size[3]):
			$TileMap.set_cell(i, ii, 0)
			
			if i == -size[0] or i == size[1] - 1:
				$TileMap.set_cell(i, ii, 1)
			
			if ii == -size[2] or ii == size[3] - 1:
				$TileMap.set_cell(i, ii, 1)

func generate_door(vector: Vector2):
	var value = [false, vector.y]
	if vector.x: value = [true, vector.x]
	
	var selected_tile = 0
	
	for i in range(value[1] * 10, 0, -value[1]):
		for ii in range(-3, 3):
			if i == 10: continue
			
			var selected = [i, ii] if value[0] else [ii, i]
			if ii == -3 or ii == 2:
				if $TileMap.get_cell(selected[0], selected[1]) == -1:
					$TileMap.set_cell(selected[0], selected[1], 1)
			else: $TileMap.set_cell(selected[0], selected[1], 0)
