extends Unit

onready var magicMissile = load("res://src/MagicMissile.tscn")

var directionToTarget := Vector2.ZERO
var level := 1 setget level_set, level_get
var expirience := 0.0 setget expirience_set, expirience_get
var expirienceToLevel := 100.0 setget expirienceToLevel_set, expirienceToLevel_get
var enemies : Array = []
var expirience_list : Array = []
var closest_target

func _ready() -> void:
	self.speed = Vector2(500.0, 500.0)
	pass

func _physics_process(delta: float) -> void:
	direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	velocity = speed * direction
	velocity = move_and_slide(velocity)
	closest_target = find_closest_target()

	attack(closest_target)

func find_closest_target() -> Object:
	var distance := INF
	var closest_target
	for enemy in enemies:
		if enemy.current_position.distance_to(self.position) < distance:
			distance = enemy.current_position.distance_to(self.position)
			directionToTarget = Vector2().direction_to(enemy.current_position - self.position)
			closest_target = enemy
	return closest_target

func attack(enemy: Object) -> void:
	if enemy:
		if $Timer.is_stopped():
			$Timer.start(0.7)
	else:
		$Timer.stop()

func level_set(value: int) -> void:
	level = value

func level_get() -> int:
	return level

func expirience_set(value: float) -> void:
	expirience += value
	if expirience >= expirienceToLevel:
		expirience -= expirienceToLevel
		self.level += 1
	print(expirience, " ", level)

func expirience_get() -> float:
	return expirience

func expirienceToLevel_set(value: float) -> void:
	expirienceToLevel = value

func expirienceToLevel_get() -> float:
	return expirienceToLevel

func set_enemy_list(list : Array) -> void:
	enemies = list

func set_expirience_list(list : Array) -> void:
	expirience_list = list

func _on_Timer_timeout() -> void:
	var missile = magicMissile.instance()
	get_parent().add_child(missile)
	missile.position = self.position
	missile.velocity = missile.speed * directionToTarget
	missile.set_enemy_list(enemies)



func _on_Area2D_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	expirience_list[area_shape_index].active = false
	self.expirience = expirience_list[area_shape_index].expirience
