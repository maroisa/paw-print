extends PawCharacter

var active = true
var nilai = ""

var player: PawCharacter
var velocity: Vector2
var target_position: float

var particle = preload("res://assets/particles/slime_particles.tscn")

onready var rng = RandomNumberGenerator.new()
onready var animstate = $AnimationTree.get("parameters/playback")

func _ready():
	rng.randomize()
	$Timer.connect("timeout", self, "refresh")
	$AttackArea.connect("body_entered", self, "on_hit")

func init(player: PawCharacter, pos: Vector2, nilai: String):
	self.global_position = pos
	self.nilai = nilai
	self.player = player
	
	return self

func refresh():
	if !player: return
	target_position = rng.randf_range(0, PI * 2)

func _physics_process(delta):
	if !player: return
	
	if animstate.get_current_node() == "Idle":
		$AttackArea/CollisionShape2D.disabled = true
		
		var to_player = (player.global_position - self.global_position)
		
		if to_player.length() <= 200:
			velocity = self.global_position.direction_to(player.global_position + Vector2.RIGHT.rotated(target_position) * 60)
		else: velocity = self.global_position.direction_to(player.global_position + Vector2.RIGHT.rotated(target_position) * 280)
		animstate.travel("Move")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Move/blend_position", velocity)
	else:
		$AttackArea/CollisionShape2D.disabled = false
		move_and_slide(velocity * 220)

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
