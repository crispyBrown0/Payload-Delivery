extends RigidBody2D

@onready var sprite = $sprite
@onready var collider = $collider
var hp = 1
@export var explosion: PackedScene

func _ready() -> void:
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(sprite.texture.get_image())
	#print(str(bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, sprite.texture.get_size()))))
	collider.polygon = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, sprite.texture.get_size()))[0]
	collider.position -= sprite.texture.get_size()/2 * sprite.scale
	collider.scale = sprite.scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_0):
		#damage(1)
		pass


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
