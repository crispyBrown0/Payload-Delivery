extends Sprite2D


@export var rotation_speed: float = 5.0
@export var cam: Camera2D
@export var projectile: PackedScene
@export var okay: Button
@export var shot_info: RichTextLabel
@export var minimap: Control

@export var map_bullet: PackedScene

var WEAPON = 0
@export var velocities: Array[int]
@export var guns: Array[Texture2D]
var names: Array[String]

var can_fire = true

var reset_in = -1
var setted_parent = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_firing()
	okay.connect("pressed", reset_firing)
	WEAPON = 1
	
	velocities = [2000, 1000, 2000, 5000, 7500, 10000, 20000, 30000, 2000]
	guns = [load("res://sprite assets/weapons/PlayerBase.png"),
			load("res://sprite assets/weapons/RubberBand.png"),
			load("res://sprite assets/weapons/BBGun.png"),
			load("res://sprite assets/weapons/9mm.png"),
			load("res://sprite assets/weapons/50BMG.png"),
			load("res://sprite assets/weapons/76mm Sherman.png"),
			load("res://sprite assets/weapons/MBT cannon.png"),
			load("res://sprite assets/weapons/Naval Gun.png"),
			load("res://sprite assets/weapons/Unguided ICBM.png")
			]
	projectile = load("res://prefabs/projectiles/0projectile.tscn")
	names = ["Placeholder",
			"Rubber Band",
			"BB Gun",
			"9 mm",
			".50 BMG Rifle",
			"Sherman Tank Gun",
			"MBT Cannon",
			"Naval Turret",
			"Ballistic Missile"]
	
	if minimap == null:
		minimap = get_tree().current_scene.get_node("UI LAYER/Control/map")
	minimap.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	aiming()
	#reset_camera()
	#try_reset_camera()
	if Input.is_action_just_pressed("debug_change_wep"):
		WEAPON += 1
		if WEAPON > 8:
			WEAPON = 0
	texture = guns[WEAPON]
	
	if !setted_parent:
		reparent(get_tree().current_scene)
		setted_parent = true
		
		var new_mapi = map_bullet.instantiate()
		new_mapi.set_col(Color.GREEN)
		new_mapi.to_follow = self
		add_child(new_mapi)
	
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("fire") and !BUTTONS.mouse_on_ui:
		try_fire()


func aiming():
	if !can_fire:
		return
	
	var target_angle = (get_global_mouse_position() - global_position).angle()
	rotation = rotate_toward(rotation, target_angle, rotation_speed * get_process_delta_time())
	rotation_degrees = clamp(rotation_degrees, -90, 30)
	
	shot_info.info_angle = rotation_degrees

func reset_camera():
	if cam.to_follow == null:
		cam.position_smoothing_enabled = true
		cam.position_smoothing_speed = 5
		cam.to_follow = self
		cam.cam_offset = Vector2(800, -400)

func try_fire():
	if !can_fire:
		return
	
	can_fire = false
	okay.visible = true
	
	var new_projectile = projectile.instantiate()
	new_projectile.projectile_velocity = velocities[WEAPON]
	new_projectile.set_sprite(guns[WEAPON])
	add_child(new_projectile)
	
	new_projectile.position = Vector2.ZERO
	new_projectile.linear_velocity = Vector2.RIGHT.rotated(rotation) * new_projectile.projectile_velocity
	new_projectile.freeze = false
	
	new_projectile.reparent(get_tree().current_scene)
	cam.to_follow = new_projectile
	cam.position_smoothing_speed = new_projectile.projectile_velocity / 200.0
	if new_projectile.projectile_velocity > 20000:
		cam.position_smoothing_enabled = false
	cam.cam_offset = Vector2.ZERO
	#reset_in = 20 #arbitrary number (see func try_reset_camera)
	shot_info.tracking_bullet = new_projectile
	
	var new_mapb = map_bullet.instantiate()
	new_mapb.set_col(Color.GOLDENROD)
	new_mapb.to_follow = new_projectile
	new_mapb.pulsing = true
	add_child(new_mapb)
	
	if velocities[WEAPON] >= 10000:
		minimap.visible = true
	
	
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
	shot_info.visible = true
	shot_info.dist_tracked = 0
	minimap.visible = false
	#shot_info.last_known_bullet_x = 0
