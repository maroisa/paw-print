extends AnimatedSprite

func _ready():
	self.connect("animation_finished", self, "on_finished")

func init(pos: Vector2, half = false):
	self.global_position = pos
	
	if half: self.play("half")
	else: self.play("default")
	
	return self

func on_finished(): self.queue_free()
