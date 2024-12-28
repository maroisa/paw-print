extends Area2D

var velocity = Vector2()

var particle = preload("res://assets/particles/lock_particles.tscn")

func _ready():
	create_tween().tween_property(self, "position:x", self.position.x + rand_range(-100, 100), 0.5)
	var tw = create_tween()
	tw.tween_property(self, "position:y", self.position.y - 64, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	yield(tw, "finished")
	create_tween().tween_property(self, "position:y", self.position.y + 64, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

func init(pos: Vector2, val: String):
	self.connect("body_entered", self, "on_hit")
	self.global_position = pos
	$C/M/Label.text = val
	return self

func _physics_process(delta):
	if velocity:
		self.global_position += velocity * 40

func on_hit(body):
	self.velocity = Vector2()
	
	if body.name == "Lock":
		get_parent().add($C/M/Label.text)
		
		$"../..".add_child(particle.instance().init(self.global_position))
		
		self.hide()
		$CollisionShape2D.set_deferred("disabled", true)
		get_tree().root.get_node("World/Player").machine.state.num_held = null

