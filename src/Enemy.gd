extends Unit
class_name Enemy
#onready var expScene = load("res://src/Expirience.tscn")

var lifetime : float = 0.0
var dead := false


func _ready() -> void:
	self.speed = Vector2(250.0, 250.0)
	pass

#func _physics_process(delta: float) -> void:
#	for i in get_tree().get_nodes_in_group("Player"):
#			direction = Vector2().direction_to(i.position - self.position)
#			velocity = speed * direction
#	velocity = move_and_slide(velocity)

func hp_set(value: float) -> void:
	hp = value
	if hp <= 0:
		dead = true
#		self.queue_free()
