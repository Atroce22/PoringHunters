extends Node2D

onready var enemy_spawner_area = get_node("EnemySpawner")
onready var timer := get_node("Timer")
onready var screen_size = get_viewport().get_visible_rect().size
onready var player = get_node("Player")

var boundary_rect : Rect2
var closest_target

func _ready() -> void:
	timer.start(1)

func _process(delta: float) -> void:
	for player in get_tree().get_nodes_in_group("Player"):
		boundary_rect = Rect2(player.position - screen_size, screen_size * 2)
	enemy_spawner_area.set_bounding_box(boundary_rect)

	player.set_enemy_list(enemy_spawner_area.enemies)
	player.set_expirience_list(enemy_spawner_area.expirience)

func _on_Timer_timeout() -> void:
	enemy_spawner_area.spawn_enemy()

func _on_StartTimer_timeout() -> void:
	timer.start()

