extends Node2D
class_name Projectile

var damage := 0.0 setget damage_set, damage_get
var speed := Vector2.ZERO setget speed_set, speed_get
var hp := 0 setget hp_set, hp_get
var level := 0 setget level_set, level_get
var velocity := Vector2.ZERO
var direction := Vector2.ZERO

func hp_set(value: int) -> void:
	hp = value
	if hp <= 0:
		self.queue_free()

func hp_get() -> int:
	return hp

func damage_set(value: float) -> void:
	damage = value

func damage_get() -> float:
	return damage

func speed_set(value: Vector2) -> void:
	speed = value

func speed_get() -> Vector2:
	return speed

func level_set(value: int) -> void:
	level = value

func level_get() -> int:
	return level
