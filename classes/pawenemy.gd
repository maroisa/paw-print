extends PawCharacter
class_name PawEnemy

var nilai: String
var velocity: Vector2
var player: PawCharacter
var circle_rotation: float

onready var rng = RandomNumberGenerator.new()

func _ready():
	var timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 2
	add_child(timer)
	
	rng.randomize()
	
	timer.connect("timeout", self, "refresh_circle")
	player = get_tree().root.get_node("World/Player")

func init(spawn_position: Vector2, nilai: String):
	self.position = spawn_position
	self.nilai = nilai
	
	return self

func refresh_circle():
	if !player: return
	circle_rotation = rng.randf_range(0, PI * 2)
