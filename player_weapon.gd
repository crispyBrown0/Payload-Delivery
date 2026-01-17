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
