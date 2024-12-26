extends PawCharacter

export var speed: int

var velocity_static: Vector2
var center_offset: Vector2

onready var animstate = $AnimationTree.get("parameters/playback")
onready var machine = get_node("PawStateMachine")

func _physics_process(delta):
	$AnimationTree.set("parameters/Idle/blend_position", velocity_static)
	$AnimationTree.set("parameters/Walk/blend_position", velocity_static)
	
	center_offset = (get_viewport().get_mouse_position() - get_viewport_rect().get_center())
	$Camera2D.offset = lerp(get_node("Camera2D").offset, center_offset / 8, 0.1)
	$Pivot.position = lerp(get_node("Pivot").position, center_offset.normalized() * 100, 0.25)
	
	$Pivot/Sprite.rotation = $Pivot.position.angle() + PI / 2
