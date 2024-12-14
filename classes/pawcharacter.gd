extends KinematicBody2D
class_name PawCharacter

export var health: int = 0
export var damage: int = 0

signal damaged(val)

func _init():
	self.connect("damaged", self, "on_damaged")
