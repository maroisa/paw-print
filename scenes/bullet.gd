extends Node2D

var velocity: Vector2

func _ready():
	$DetectArea/AnimatedSprite.connect("animation_finished", self, "destruct")
	$DetectArea.connect("body_entered", self, "on_shoot")

func _physics_process(delta):
	$DetectArea.position += velocity * 6
	if $DetectArea.position.length() >= 300:
		$DetectArea/AnimatedSprite.play("default")

func destruct():
	self.queue_free()

func on_shoot(body):
	if body is PawCharacter:
		body.damaged(1)
	
	velocity = Vector2()
	$DetectArea/AnimatedSprite.play("default")
