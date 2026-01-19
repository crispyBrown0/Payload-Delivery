extends Node2D

@export var enemy: PackedScene
@export var shot_info: RichTextLabel
@export var camera: Camera2D
@export var mapobj: PackedScene

var type = 0
var sprites: Array[Texture2D]
var scales: Array[float]
var distances: Array[Vector2]
var amt = 5
var spawned = 0
var spawn_timer = 1

var all_enemies: Array
var kills = 0

func _ready() -> void:
	sprites = [
		load("res://sprite assets/enemies/PaperBoat.png"),
		load("res://sprite assets/enemies/Cans.png"),
		load("res://sprite assets/enemies/MetalTarget.png"),
		load("res://sprite assets/enemies/Car.png"),
		load("res://sprite assets/enemies/TigerTank.png"),
		load("res://sprite assets/enemies/Bunker.png"),
		load("res://sprite assets/enemies/BattleshipYamoto.png")
	]
	scales = [
		1,
		1,
		1,
		1.5,
		2,
		3,
		3.5
	]
	distances = [
		Vector2(5, 13),
		Vector2(25, 45),
		Vector2(125, 250),
		Vector2(250, 620),
		Vector2(650, 1050),
		Vector2(2000, 4000),
		Vector2(5000, 9000)
	]

func spawn_enemies():
	kills = 0
	amt = 5
	if type == 0:
		amt = 3
	if type == 1:
		amt = 4
	if type >= 7:
		amt = 0
	spawned = 0
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass_info()
	
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_timer = 0.5
		try_spawning()

func pass_info():
	var closest_pos = 0
	var camx = camera.get_screen_center_position().x
	
	if all_enemies.size() > 0:
		closest_pos = 0
		var looking = 0
		while looking < all_enemies.size():
			if all_enemies[looking] == null:
				all_enemies.remove_at(looking)
				kills += 1
				get_tree().current_scene.killd()
			else:
				if abs(all_enemies[looking].position.x-camx) < abs(closest_pos - camx) or closest_pos == 0:
					closest_pos = all_enemies[looking].position.x
				looking += 1
	
	shot_info.enemy_x = closest_pos

func follow_closest_enemy(didhit: bool):
	if all_enemies.size() < 0 or camera.to_follow != null:
		return
	var looking = 0
	var closest_pos = 0
	var closest = 0
	var camx = 0
	
	if !didhit: #if missed an enemy, find the closest to where the bullet landed
		camx = camera.get_screen_center_position().x
	
	while looking < all_enemies.size():
			if all_enemies[looking] == null:
				all_enemies.remove_at(looking)
				kills += 1
				get_tree().current_scene.killd()
			else:
				if abs(all_enemies[looking].position.x-camx) < abs(closest_pos-camx) or closest_pos == 0:
					closest_pos = all_enemies[looking].position.x
					closest = looking
				looking += 1
	
	if all_enemies.size() <= closest:
		camera.to_follow = null
	else:
		camera.to_follow = all_enemies[closest]
	camera.position_smoothing_speed = 5
	camera.position_smoothing_enabled = true

func wipe_all():
	for looking in all_enemies:
		looking.queue_free()
	all_enemies = []

func try_spawning():
	if spawned < amt:
		var new_enemy  = enemy.instantiate()
		#new_enemy.position = Vector2(lerp(distances[type].x, distances[type].y, i * 1.0 / amt) * 100, -500 * 100)
		new_enemy.position = Vector2(randf_range(distances[type].x, distances[type].y) * 100, -500 * 100)
		#new_enemy.position = Vector2(1000, -50000)
		new_enemy.get_node("sprite").texture = sprites[type]
		var to_scale = scales[type]
		if to_scale == 1:
			to_scale *= randf_range(0.8, 1.3)
		new_enemy.get_node("sprite").scale = Vector2.ONE * to_scale
		add_child(new_enemy)
		
		all_enemies.append(new_enemy)
		
		var new_mape = mapobj.instantiate()
		new_mape.set_col(Color.RED)
		new_mape.to_follow = new_enemy
		add_child(new_mape)
		
		spawned += 1
