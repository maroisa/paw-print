extends PawState

var distance: Vector2
var random_distance: Vector2

func update():
	if !owner.player: return
	distance = owner.player.global_position - owner.global_position
	random_distance = ((owner.player.global_position + Vector2.RIGHT.rotated(owner.circle_rotation) * 300) - owner.global_position)
	
	if random_distance.length() >= 300: owner.velocity = random_distance.normalized()
	else: owner.velocity = distance.normalized()
	
	if owner.velocity: owner.animstate.travel("Move")
	else: owner.animstate.travel("Idle")
	
	if distance.length() < 160:
		machine.travel("Attack")
	
	owner.move_and_slide(owner.velocity * 150)
