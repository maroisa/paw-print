extends KinematicBody2D
class_name PawCharacter

export var health: int = 1
export var damage: int = 1

signal damaged(val)

func _init():
	self.connect("damaged", self, "damaged")

func damaged(damage: int):
	health -= 1
	if health <= 0:
		die()

func die():
	print(self.name, " has died")
