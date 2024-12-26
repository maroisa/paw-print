extends Area2D

var velocity = Vector2()

var particle = preload("res://assets/particles/lock_particles.tscn")

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

