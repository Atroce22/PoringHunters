extends Projectile


func _ready() -> void:
	self.damage = 100.0
	self.speed = Vector2(500.0, 500.0)
	self.hp = 1

func _physics_process(delta: float) -> void:
	for i in get_tree().get_nodes_in_group("Enemy"):
		if $".".overlaps_body(i):
			i.take_damage(damage)
			self.hp -= 1
	self.translate(velocity * delta)
	if !$VisibilityNotifier2D.is_on_screen():
		self.queue_free()
