extends Area2D

var velocity: Vector2

func _physics_process(delta):
	if velocity:
		self.position += velocity * 5
		
	print(self.position.length())
	
	if self.position.length() > 500:
		queue_free()
