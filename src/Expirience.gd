extends Area2D

var expirience := 10.0 setget expirience_set, expirience_get

func expirience_set(value: float) -> void:
	expirience = value

func expirience_get() -> float:
	return expirience

func _physics_process(delta: float) -> void:
	for i in get_tree().get_nodes_in_group("Player"):
		if $".".overlaps_body(i):
			i.expirience = expirience
			$".".queue_free()
