extends PawCharacter

var active = true
var nilai = ""

func init(pos: Vector2, nilai: String):
	self.global_position = pos
	self.nilai = nilai
	return self

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	self.modulate.a = 0.5
	active = false
	get_parent().refresh()
