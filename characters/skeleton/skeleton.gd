extends PawCharacter

var velocity: Vector2 = Vector2.DOWN
var nilai: String
var player: PawCharacter
var active = true
var particle = preload("res://assets/particles/skeleton_particles.tscn")

onready var animstate = $AnimationTree.get("parameters/playback")

func init(player: PawCharacter, pos: Vector2, nilai: String):
	self.global_position = pos
	self.nilai = nilai
	self.player = player
	
	$Timer.connect("timeout", $PawStateMachine/Normal, "refresh")
	$AttackArea.connect("body_entered", self, "on_hit")
	
	return self

func _physics_process(delta):
	$AttackArea.rotation = velocity.angle()
	$AnimationTree.set("parameters/Idle/blend_position", velocity)
	$AnimationTree.set("parameters/Move/blend_position", velocity)
	$AnimationTree.set("parameters/Attack/blend_position", velocity)

func on_hit(body: PawCharacter):
	body.emit_signal("damaged", self.damage)

func damaged(damage):
	.damaged(damage)
	
	add_child(particle.instance().init())
	
	if health <= 0: return
	$Sprite.modulate = Color(10, 0, 0)
	yield(get_tree().create_timer(0.08), "timeout")
	$Sprite.modulate = Color(1, 1, 1)

func die():
	player = null
	$AnimationTree.active = false
	$CollisionShape2D.set_deferred("disabled", true)
	self.modulate.a = 0.5
	active = false
	get_parent().refresh()
