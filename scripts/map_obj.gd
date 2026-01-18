extends TextureRect

var to_follow
var pulsing = false

var prev_col

var timer = 0

func _ready() -> void:
	var new_parent = get_tree().current_scene.get_node("UI LAYER/Control/map")
	if new_parent != null:
		reparent(new_parent)
	else:
		queue_free()
	rotation = 0

func set_col(newcol: Color):
	modulate = newcol
	prev_col = newcol

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	
	if to_follow == null:
		queue_free()
		return
	
	do_pos()
	pulse()

func do_pos():
	var x = (to_follow.position.x + 1000 * 100) / 1000 - 7.5
	var y = (to_follow.position.y + 2000 * 100) / 1000 - 7.5
	position = Vector2(x, y)
	tooltip_text = root.str_m_or_km(to_follow.position.x / 100)

func pulse():
	if !pulsing:
		return
	scale = Vector2.ONE * (cos(timer * 10) * 0.25 + 0.75)


func _on_mouse_entered() -> void:
	modulate = Color.AQUA


func _on_mouse_exited() -> void:
	modulate = prev_col
