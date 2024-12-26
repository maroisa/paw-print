extends PawState

var distance: Vector2

func update():
	if !owner.player: return
	distance = owner.player.global_position - owner.global_position
	owner.velocity = distance.normalized()
	
	if owner.velocity: owner.animstate.travel("Move")
	else: owner.animstate.travel("Idle")
	
	owner.move_and_slide(owner.velocity * 150)
