extends Area2D

var velocity: Vector2

func _physics_process(delta):
	if velocity:
		self.global_position += velocity * 5
