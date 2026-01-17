extends Sprite2D


@export var rotation_speed: float = 5.0
@export var cam: Camera2D
@export var projectile: PackedScene
@export var okay: Button

var can_fire = true

var reset_in = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_firing()
	okay.connect("pressed", reset_firing)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	aiming()
	#reset_camera()
	try_reset_camera()
	
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("fire"):
		try_fire()


func aiming():
	var target_angle = (get_global_mouse_position() - global_position).angle()
	rotation = rotate_toward(rotation, target_angle, rotation_speed * get_process_delta_time())
	rotation_degrees = clamp(rotation_degrees, -90, 30)

func reset_camera():
	if cam.to_follow == null:
		cam.to_follow = self
		cam.cam_offset = Vector2(800, -600)

func try_fire():
	if !can_fire:
		return
	
	can_fire = false
	okay.visible = true
	
	var new_projectile = projectile.instantiate()
	#get_tree().root.add_child(new_projectile)
	add_child(new_projectile)
	
	new_projectile.position = Vector2.ZERO
	new_projectile.linear_velocity = Vector2.RIGHT.rotated(rotation) * new_projectile.projectile_velocity
	new_projectile.freeze = false
	
	new_projectile.reparent(get_tree().current_scene)
	cam.to_follow = new_projectile
	cam.cam_offset = Vector2.ZERO
	reset_in = 20 #arbitrary number (see func try_reset_camera)
	
	#new_projectile.global_transform = current_projectile.global_transform
	#new_projectile.freeze = false
	#new_projectile.linear_velocity = Vector2.RIGHT.rotated(global_rotation) * current_projectile.projectile_velocity
	#current_projectile.queue_free()

#in case some bug prevents the camera from being reset after shooting a bullet. This will wait a certain duration after firing and reset the camera in case it's still at the bullet
func try_reset_camera():
	if reset_in > 0:
		reset_in -= get_process_delta_time()
		if reset_in <= 0:
			reset_camera()

func reset_firing():
	cam.to_follow = null
	reset_camera()
	okay.visible = false
	can_fire = true
