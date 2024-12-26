extends PawState

var initial = false

func enter():
	owner.animstate.travel("Attack")
	yield(get_tree().create_timer(0.3), "timeout")
	owner.get_node("AttackArea/CollisionShape2D").set_deferred("disabled", false)
	yield(get_tree().create_timer(0.1), "timeout")
	owner.get_node("AttackArea/CollisionShape2D").set_deferred("disabled", true)

func update():
	if owner.animstate.get_current_node() == "Move":
		machine.travel("Normal")
