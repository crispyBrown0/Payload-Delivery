extends RigidBody2D

@onready var sprite = $sprite
@onready var collider = $collider
var hp = 1
@export var explosion: PackedScene
@onready var downray = $DOWNRAY

var bitmap: BitMap

var when_check = 0.1
var checked = false

func _ready() -> void:
	bitmap = BitMap.new()
	bitmap.create_from_image_alpha(sprite.texture.get_image())
	#print(str(bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, sprite.texture.get_size()))))
	collider.polygon = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, sprite.texture.get_size()), 4)[0]
	collider.position -= sprite.texture.get_size()/2 * sprite.scale
	collider.scale = sprite.scale
	
	#find_center()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	downray.global_rotation_degrees = 0
	when_check -= delta
	if when_check <= 0 and !checked:
		if downray.is_colliding():
			var pt = downray.get_collision_point()
			position = pt + Vector2(0, -1 * bitmap.get_size().y)
			if position.y > -400 * 100:
				checked = true


func damage(amt: int):
	hp -= amt
	if hp<=0:
		die()

func die():
	var new_explosion = explosion.instantiate()
	new_explosion.scale = sprite.texture.get_size()/100.0 * sprite.scale
	add_child(new_explosion)
	new_explosion.reparent(get_parent())
	queue_free()

func find_center():
	var poly = collider.polygon
	var leftmost = poly[0].x
	var rightmost = poly[0].x
	var uppermost = poly[0].y
	var lowermost = poly[0].y
	
	for looking in poly:
		if looking.x > rightmost:
			rightmost = looking.x
		if looking.x < leftmost:
			leftmost = looking.y
		if looking.y > lowermost:
			lowermost = looking.y
		if looking.y < uppermost:
			uppermost = looking.y
	
	center_of_mass = Vector2(leftmost + (rightmost - leftmost)/2,   uppermost + (lowermost - uppermost)/2)
	center_of_mass -= sprite.texture.get_size()/2 * sprite.scale
	print(center_of_mass)
	downray.position = center_of_mass
