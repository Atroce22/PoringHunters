extends Projectile

var enemies : Array = []

func _ready() -> void:
	self.damage = 100.0
	self.speed = Vector2(500.0, 500.0)
	self.hp = 3

func _physics_process(delta: float) -> void:
	self.translate(velocity * delta)
	if !$VisibilityNotifier2D.is_on_screen():
		self.queue_free()

func set_enemy_list(list : Array) -> void:
	enemies = list

func _on_MagicMissile_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	self.hp -= 1
	enemies[area_shape_index].take_damage(damage)
