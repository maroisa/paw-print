extends PawState

var vector: Vector2
var velocity: Vector2

onready var shoot_cooldown = owner.get_node("ShootCooldownTimer")

func enter():
	var tw: Tween = player.get_node("Tween")
	var book = player.get_node("BookSprite")
	tw.interpolate_property(book, "modulate:a", 0, 1, 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tw.start()

func update():
	if owner.health <= 0: machine.travel("Die")
	
	move_controller()
	shoot_controller()

func move_controller():
	vector = Input.get_vector("p_left", "p_right", "p_up", "p_down")
	var sound: AudioStreamPlayer2D = owner.get_node("WalkSound")
	
	if vector:
		if !sound.playing: sound.play()
		player.velocity_static = vector
		player.animstate.travel("Walk")
	else:
		if sound.playing: sound.stop()
		player.animstate.travel("Idle")
	
	velocity = lerp(velocity, vector, 0.16)
	
	owner.get_node("BookSprite").position = owner.get_node("Pivot").position
	owner.get_node("BookSprite").rotation = owner.get_node("Pivot").position.angle() + PI / 2
	
	player.move_and_slide(velocity * player.speed * 10)

func shoot_controller():
	if Input.is_action_pressed("p_action") && shoot_cooldown.is_stopped():
		shoot_cooldown.start()
		player.get_parent().bullet_pool.spawn(player.get_node("Pivot").global_position, player.center_offset.normalized())
