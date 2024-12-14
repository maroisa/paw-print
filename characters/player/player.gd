extends PawCharacter

export var speed = 20

var velocity: Vector2
var velocity_static: Vector2

func _physics_process(delta):
	$Sprite.rotation = lerp_angle($Sprite.rotation, velocity_static.angle(), 0.2)
	$Sprite.rotation = fposmod($Sprite.rotation, PI * 2)
