extends Area2D

var active = true

var velocity = Vector2()

func init(pos: Vector2, val: String):
	self.connect("body_entered", self, "on_hit")
	self.global_position = pos
	$C/Label.text = val
	return self

func _physics_process(delta):
	if velocity:
		self.global_position += velocity * 40

func on_hit(body):
	self.velocity = Vector2()
	print(body)
