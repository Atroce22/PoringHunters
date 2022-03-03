extends Node2D

export (Image) var enemy_image

#onready var enemyScene = load("res://src/Enemy.tscn")
onready var screenSize = get_viewport().get_visible_rect().size
onready var origin := get_node("Origin") as Position2D
onready var shared_area := get_node("SharedArea") as Area2D
onready var exp_area := get_node("ExpArea") as Area2D
#onready var expScene = load("res://src/Expirience.tscn")

var max_lifetime = 10.0
var enemies : Array = []
var expirience : Array = []
var bounding_box : Rect2
#var space : RID
#var shape : RID

func _ready() -> void:
#	space = Physics2DServer.space_create()
#	shape = Physics2DServer.area_create()
#	Physics2DServer.area_set_space(shape, space)
	randomize()

func _exit_tree() -> void:
	for enemy in enemies:
		Physics2DServer.free_rid((enemy as Enemy).shape_id)
	enemies.clear()
#	for expi in expirience:
#		Physics2DServer.free_rid((expi as Expirience).shape_id)
#	expirience.clear()

func _physics_process(delta: float) -> void:

	var used_transform = Transform2D()
	var enemies_queued_for_destruction = []
	var expi_queued_for_destruction = []

	for i in enemies.size():

		var enemy = enemies[i] as Enemy

		if (!bounding_box.has_point(enemy.current_position) || enemy.lifetime >= max_lifetime) || enemy.dead:
			enemies_queued_for_destruction.append(enemy)
			continue

		for player in get_tree().get_nodes_in_group("Player"):
			enemy.direction = Vector2().direction_to(player.position - enemy.current_position)
			enemy.velocity = enemy.direction * enemy.speed * delta

		enemy.current_position += enemy.velocity
		used_transform.origin = enemy.current_position
		Physics2DServer.area_set_shape_transform(shared_area.get_rid(), i, used_transform)

		enemy.lifetime += delta

	for j in expirience.size():
		var expi = expirience[j] as Expirience
		if !expi.active:
			expi_queued_for_destruction.append(expi)
			continue

	for expi in expi_queued_for_destruction:
		Physics2DServer.free_rid(expi.shape_id)
		expirience.erase(expi)

	for enemy in enemies_queued_for_destruction:
#		var expDrop = expScene.instance()
#		get_parent().add_child(expDrop)
#		expDrop.position = enemy.current_position
		Physics2DServer.free_rid(enemy.shape_id)
		enemies.erase(enemy)
		spawn_expirience(enemy)

	update()

func _draw() -> void:
	var offset = enemy_image.get_size() / 2.0
	for enemy in enemies:
		draw_texture(enemy_image, enemy.current_position - offset)
	for expi in expirience:
		draw_texture(enemy_image, expi.current_position - offset, Color.brown)

func set_bounding_box(box: Rect2) -> void:
	bounding_box = box

func spawn_enemy() -> void:
	var player = get_tree().get_nodes_in_group("Player")[0]
	var enemy : Enemy = Enemy.new()
	enemy.current_position.x = rand_range(player.position.x - screenSize.x, player.position.x + screenSize.x)
	enemy.current_position.y = rand_range(player.position.y - screenSize.y, player.position.y + screenSize.y)
	enemy.add_to_group("Enemy")
	_configure_collision_for_enemy(enemy)
	enemies.append(enemy)

func _configure_collision_for_enemy(enemy: Enemy) -> void:
	var used_transform := Transform2D(0, position)
	used_transform.origin = enemy.current_position

	var _circle_shape = Physics2DServer.circle_shape_create()
	Physics2DServer.shape_set_data(_circle_shape, 32)

	Physics2DServer.area_add_shape(shared_area.get_rid(), _circle_shape, used_transform)
#	Physics2DServer.area_set_collision_layer(shared_area.get_rid(), 2)
#	Physics2DServer.area_set_collision_mask(shared_area.get_rid(), 1)

	enemy.shape_id = _circle_shape


func spawn_expirience(enemy: Enemy) -> void:
	var expi : Expirience = Expirience.new()
	expi.add_to_group("Entity")
	_configure_collision_for_expirience(expi, enemy)
	expi.expirience = rand_range(1, 10)
	expirience.append(expi)

func _configure_collision_for_expirience(expi: Expirience, enemy: Enemy) -> void:
	var used_transform := Transform2D(0, position)
	expi.current_position = enemy.current_position
	used_transform.origin = expi.current_position

	var _circle_shape = Physics2DServer.circle_shape_create()
	Physics2DServer.shape_set_data(_circle_shape, 16)

	Physics2DServer.area_add_shape(exp_area.get_rid(), _circle_shape, used_transform)

	expi.shape_id = _circle_shape

#	Physics2DServer.area_set_collision_layer(exp_area.get_rid(), 3)
#	Physics2DServer.area_set_collision_mask(exp_area.get_rid(), 1)


#func _on_Timer_timeout() -> void:
#	var enemy = enemyScene.instance()
#	get_parent().add_child(enemy)
#	for i in get_tree().get_nodes_in_group("Player"):
#		enemy.position.x = rand_range(i.position.x - screenSize.x, i.position.x + screenSize.x)
#		enemy.position.y = rand_range(i.position.y - screenSize.y, i.position.y + screenSize.y)
