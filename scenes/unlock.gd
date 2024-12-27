extends Node2D

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "on_finished")

func init(pos: Vector2, half = false):
	self.global_position = pos
	
	if half: $AnimationPlayer.play("unlock_half")
	else: $AnimationPlayer.play("unlock")
	
	return self

func on_finished(anim_name: String):
	self.queue_free()
