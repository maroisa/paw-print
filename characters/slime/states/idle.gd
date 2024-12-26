extends PawState

func update():
	
	
	$"../..".velocity = $"../..".global_position.direction_to($"../..".player.global_position)
	$"../..".global_position += $"../..".velocity * 4
	
	print($"../..".velocity)
