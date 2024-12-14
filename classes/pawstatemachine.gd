extends Node
class_name PawStateMachine

export var initial_state = "Idle"
onready var state: Node = get_node(initial_state)

func _ready():
	for child in get_children():
		child.machine = self
	
	yield(owner, "ready")
	state.enter()

func _physics_process(delta):
	state.update()

func travel(new_state):
	if not has_node(new_state): return
	if state.name == new_state: return
	
	state.exit()
	state = get_node(new_state)
	state.enter()
