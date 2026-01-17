extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	reparent(get_tree().current_scene)
	move_to_front()
	position = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().paused = false
		queue_free()
