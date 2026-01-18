extends Node2D

@export var enemy: PackedScene
@export var shot_info: RichTextLabel
@export var camera: Camera2D
@export var mapobj: PackedScene

var all_enemies: Array

func _ready() -> void:
	pass#spawn_enemies()

func spawn_enemies():
	for i in range(1, 10):
		var new_enemy  = enemy.instantiate()
		new_enemy.position = Vector2(i * 100 * 980, -500 * 100)
		add_child(new_enemy)
		
		all_enemies.append(new_enemy)
		
		var new_mape = mapobj.instantiate()
		new_mape.set_col(Color.RED)
		new_mape.to_follow = new_enemy
		add_child(new_mape)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass_info()

func pass_info():
	var closest_pos = 0
	var camx = camera.get_screen_center_position().x
	
	if all_enemies.size() > 0:
		closest_pos = 0
		var looking = 0
		while looking < all_enemies.size():
			if all_enemies[looking] == null:
				all_enemies.remove_at(looking)
			else:
				if abs(all_enemies[looking].position.x-camx) < abs(closest_pos - camx) or closest_pos == 0:
					closest_pos = all_enemies[looking].position.x
				looking += 1
	
	shot_info.enemy_x = closest_pos

func follow_closest_enemy(didhit: bool):
	print("called")
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
			else:
				if abs(all_enemies[looking].position.x-camx) < abs(closest_pos-camx) or closest_pos == 0:
					closest_pos = all_enemies[looking].position.x
					closest = looking
				looking += 1
	
	camera.to_follow = all_enemies[closest]
	camera.position_smoothing_speed = 5
	camera.position_smoothing_enabled = true
