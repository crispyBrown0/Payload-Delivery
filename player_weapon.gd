extends Sprite2D


@export var rotation_speed: float = 5.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target_angle = (get_global_mouse_position() - global_position).angle()
	rotation = rotate_toward(rotation, target_angle, rotation_speed * delta)
	rotation_degrees = clamp(rotation_degrees, -90, 30)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		var current_projectile = $Projectile
		if current_projectile:
			var new_projectile = load("res://projectile.tscn").instantiate()
			get_tree().root.add_child(new_projectile)
			new_projectile.global_transform = current_projectile.global_transform
			new_projectile.freeze = false
			new_projectile.linear_velocity = Vector2.RIGHT.rotated(global_rotation) * current_projectile.projectile_velocity
			current_projectile.queue_free()
