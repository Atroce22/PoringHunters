extends KinematicBody2D
class_name Unit

var hp := 100.0 setget hp_set, hp_get
var speed := Vector2(300.0, 300.0) setget speed_set, speed_get
var velocity := Vector2.ZERO
var damage := 10.0
var direction := Vector2.ZERO

func hp_set(value: float) -> void:
	hp = value
	if hp <= 0:
		self.queue_free()

func hp_get() -> float:
	return hp

func damage_set(value: float) -> void:
	damage = value

func damage_get() -> float:
	return damage

func speed_set(value: Vector2) -> void:
	speed = value

func speed_get() -> Vector2:
	return speed

func take_damage(value: float) -> void:
	self.hp -= value
