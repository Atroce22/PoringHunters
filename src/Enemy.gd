extends Unit
class_name Enemy

var lifetime : float = 0.0
var dead := false


func _ready() -> void:
	self.speed = Vector2(250.0, 250.0)
	pass

func hp_set(value: float) -> void:
	hp = value
	if hp <= 0:
		dead = true
		self.queue_free()
