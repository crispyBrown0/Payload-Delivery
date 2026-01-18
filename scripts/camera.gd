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
	if Engine.time_scale > 1:
		position_smoothing_enabled = false
	if to_follow != null:
		calc_offset()
		#position = position.lerp(to_follow.position + current_offset, delta * 5)
		position = to_follow.position + current_offset
		
		#position_smoothing_speed = 5
		var smooth_distance = (get_target_position() - get_screen_center_position()).length()

func calc_offset():
	current_offset = cam_offset
	if cam_rotates:
		current_offset = current_offset.rotated(to_follow.rotation)
