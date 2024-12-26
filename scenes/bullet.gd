extends Area2D

var velocity: Vector2

func _ready():
	$DestructTimer.connect("timeout", self, "on_self_destruct")
	$AnimatedSprite.connect("animation_finished", self, "on_finished")
	self.connect("body_entered", self, "on_hit")

func _physics_process(delta):
	if velocity:
		self.global_position += velocity * 16

func init(pos: Vector2, vel: Vector2):
	self.global_position = pos
	self.velocity = vel
	return self

func on_hit(body: Node2D):
	if body is PawCharacter:
		body.emit_signal("damaged", get_parent().get_node("Player").damage)
	
	$AnimatedSprite.play("default")
	velocity = Vector2()

func on_finished():
	self.queue_free()

func on_self_destruct():
	$AnimatedSprite.play("default")
