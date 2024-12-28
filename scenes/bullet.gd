extends Area2D

var velocity: Vector2

func _ready():
	self.hide()
	$AnimatedSprite.connect("animation_finished", self, "deactivate")
	self.connect("body_entered", self, "on_hit")

func activate(spawn_position: Vector2, velocity: Vector2):
	self.show()
	self.velocity = velocity
	self.global_position = spawn_position
	$AnimatedSprite.playing = false
	$AnimatedSprite.frame = 0
	$CollisionShape2D.disabled = false

func deactivate():
	self.velocity = Vector2()
	$CollisionShape2D.disabled = true
	self.hide()
	get_parent().despawn(self)

func _physics_process(delta):
	if velocity: self.global_position += velocity * 15

func on_hit(body):
	if body is PawEnemy:
		$HitSound.pitch_scale = rand_range(0.7, 1.3)
		$HitSound.play()
		body.emit_signal("damaged", 1)
	
	$AnimatedSprite.play("default")
	velocity = Vector2()
