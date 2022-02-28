extends Node

onready var enemyScene = load("res://src/Enemy.tscn")
onready var screenSize = get_viewport().get_visible_rect().size

func _ready() -> void:
	$Timer.start()
	randomize()


func _on_Timer_timeout() -> void:
	var enemy = enemyScene.instance()
	get_parent().add_child(enemy)
	for i in get_tree().get_nodes_in_group("Player"):
		enemy.position.x = rand_range(i.position.x - screenSize.x, i.position.x + screenSize.x)
		enemy.position.y = rand_range(i.position.y - screenSize.y, i.position.y + screenSize.y)
