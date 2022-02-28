extends Unit

onready var magicMissile = load("res://src/MagicMissile.tscn")

var directionToTarget := Vector2.ZERO
var level := 1 setget level_set, level_get
var expirience := 0.0 setget expirience_set, expirience_get
var expirienceToLevel := 100.0 setget expirienceToLevel_set, expirienceToLevel_get

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	direction = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	velocity = speed * direction
	velocity = move_and_slide(velocity)
	var closest_target := find_closest_target()
	attack(closest_target)

func find_closest_target() -> Object:
	var distance := INF
	var enemy
	for i in get_tree().get_nodes_in_group("Enemy"):
		if i.global_position.distance_to(self.global_position) < distance:
			distance = i.global_position.distance_to(self.global_position)
			directionToTarget = Vector2().direction_to(i.position - self.position)
			enemy = i
	return enemy

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


func _on_Timer_timeout() -> void:
	var missile = magicMissile.instance()
	get_parent().add_child(missile)
	missile.position = self.position
	missile.velocity = missile.speed * directionToTarget
