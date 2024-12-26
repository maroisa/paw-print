extends Particles2D

func init():
	self.connect("finished", self, "on_finished")
	self.emitting = true
	return self

func on_finished(): self.queue_free()
