extends Area2D
class_name Expirience

var expirience := 10.0 setget expirience_set, expirience_get
var shape_id : RID
var active = true
var current_position : Vector2

func expirience_set(value: float) -> void:
	expirience = value

func expirience_get() -> float:
	return expirience

