extends Node2D

var lock_position: Array

var soal: PoolStringArray = []

func init(soal: PoolStringArray, tilemap_tileset: TileSet, lock_tileset: TileSet):
	self.soal = soal
	$EnterArea.connect("body_entered", $Enemies, "generate_enemies", [$EnterArea])
	$TileMap.tile_set = tilemap_tileset
	$LockTileMap.tile_set = lock_tileset
	return self

func generate_room():
	$TileMap.clear()
	
	var size: PoolIntArray = [
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

func generate_hallway(vector: Vector2):
	var isX = vector.x != 0
	var selected = Vector2()
	
	for i in 11:
		for ii in range(-3, 3):
			if isX:
				selected = Vector2(clamp(vector.x * i, -10, 9), ii)
			else: selected = Vector2(ii, clamp(vector.y * i, -10, 9))
			
			if $TileMap.get_cellv(selected) == 0: continue
			
			if $TileMap.get_cellv(selected) == 1 and not ii in [-3, 2]:
				lock_position.append(selected)
			
			if ii == -3 or ii == 2:
				$TileMap.set_cellv(selected, 1)
				continue
			
			$TileMap.set_cell(selected.x, selected.y, 0)

func generate_lock():
	for i in lock_position:
		$LockTileMap.set_cellv(i, 0)
