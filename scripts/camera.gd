extends Camera2D

static var to_follow
static var cam_offset: Vector2
static var cam_rotates: bool

var current_offset


func _ready() -> void:
	cam_offset = Vector2(100, 0)
	cam_rotates = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if to_follow != null:
		calc_offset()
		position = to_follow.position + current_offset

func calc_offset():
	current_offset = cam_offset
	if cam_rotates:
		current_offset = current_offset.rotated(to_follow.rotation)
