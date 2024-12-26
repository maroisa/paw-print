extends PawState

var vector: Vector2
var velocity: Vector2

const bullet = preload("res://scenes/bullet.tscn")

func enter():
	var tw: Tween = player.get_node("Tween")
	var book = player.get_node("Pivot/Sprite")
	tw.interpolate_property(book, "position", -book.get_parent().position, Vector2(), 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tw.interpolate_property(book, "modulate:a", 0, 1, 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tw.start()

func update():
	move_controller()
	shoot_controller()

func move_controller():
	vector = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	
	if vector:
		player.velocity_static = vector
		player.animstate.travel("Walk")
	else:
		player.animstate.travel("Idle")
	
	velocity = lerp(velocity, vector, 0.16)
	
	player.move_and_slide(velocity * player.speed * 10)

func shoot_controller():
	var bullet_ins = bullet.instance()
	if Input.is_action_just_pressed("p_action"):
		bullet_ins = bullet.instance()
		player.get_parent().add_child(bullet_ins.init(
			player.get_node("Pivot").global_position,
			player.center_offset.normalized()
		))
