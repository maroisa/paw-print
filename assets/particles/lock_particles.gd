extends Particles2D

func init(pos: Vector2):
	self.global_position = pos
	self.connect("finished", self, "on_finished")
	self.emitting = true
	return self

func on_finished(): self.queue_free()
