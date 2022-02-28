extends Projectile

var detecting := true
var enemies : Array = []

func _ready() -> void:
	self.damage = 25.0
	self.speed = Vector2(500.0, 500.0)
	self.hp = 3

func _physics_process(delta: float) -> void:
	for i in get_tree().get_nodes_in_group("Enemy"):
		if $".".overlaps_body(i):
			i.take_damage(damage)
			self.hp -= 1
	self.translate(velocity * delta)
	if !$VisibilityNotifier2D.is_on_screen():
		self.queue_free()

func set_enemy_list(list : Array) -> void:
	enemies = list

func _on_MagicMissile_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if detecting:
		self.hp -= 1
		enemies[area_shape_index].take_damage(damage)
#		detecting = false
#		yield(get_tree().create_timer(0.1), "timeout")
#		detecting = true
