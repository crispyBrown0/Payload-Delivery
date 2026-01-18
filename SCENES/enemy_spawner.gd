extends Node2D

@export var enemy: PackedScene
@export var shot_info: RichTextLabel
@export var camera: Camera2D

var all_enemies: Array

func _ready() -> void:
	pass#spawn_enemies()

func spawn_enemies():
	for i in range(1, 10):
		var new_enemy  = enemy.instantiate()
		new_enemy.position = Vector2(i * 100 * 980, -500 * 100)
		add_child(new_enemy)
		
		all_enemies.append(new_enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass_info()

func pass_info():
	var closest_pos = 0
	
	if all_enemies.size() > 0:
		closest_pos = 0
		var looking = 0
		while looking < all_enemies.size():
			if all_enemies[looking] == null:
				all_enemies.remove_at(looking)
			else:
				if all_enemies[looking].position.x < closest_pos or closest_pos == 0:
					closest_pos = all_enemies[looking].position.x
				looking += 1
	
	shot_info.enemy_x = closest_pos

func follow_closest_enemy():

	if all_enemies.size() < 0 or camera.to_follow != null:
		return
	var looking = 0
	var closest_pos = 0
	var closest = 0
	while looking < all_enemies.size():
			if all_enemies[looking] == null:
				all_enemies.remove_at(looking)
			else:
				if all_enemies[looking].position.x < closest_pos or closest_pos == 0:
					closest_pos = all_enemies[looking].position.x
					closest = looking
				looking += 1
	
	camera.to_follow = all_enemies[closest]
	camera.position_smoothing_speed = 5
	camera.position_smoothing_enabled = true
