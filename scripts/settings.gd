extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	
	var new_layer = CanvasLayer.new()
	get_tree().current_scene.add_child(new_layer)
	new_layer.layer = 3
	
	reparent(new_layer)
	
	
	#reparent(get_tree().current_scene)
	move_to_front()
	position = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = false
		queue_free()
