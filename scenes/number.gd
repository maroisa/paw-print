extends Area2D

export var nilai: String

var velocity = Vector2()

func _ready():
	self.connect("body_entered", self, "on_shoot")
	$C/Label.connect("mouse_entered", self, "mouse_entered")
	$C/Label.connect("mouse_exited", self, "mouse_exited")
	$C/Label.text = nilai

func _physics_process(delta):
	if velocity:
		self.global_position += velocity * 10

func on_shoot(body: Node2D):
	velocity = Vector2()
	
	if body is StaticBody2D:
		body.get_parent().queue_free()
		print(get_parent().queue_free())

func set_cursor(cursor):
	$C/Label.mouse_default_cursor_shape = cursor

func mouse_entered():
	get_tree().root.get_node("World/Player").emit_signal("number_entered", self)

func mouse_exited():
	get_tree().root.get_node("World/Player").emit_signal("number_exited")
