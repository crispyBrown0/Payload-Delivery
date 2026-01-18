extends RigidBody2D


@export var projectile_velocity: float = 2000
@export var hi_speed: bool
@export var dirt_effect: PackedScene
var dmg = 1


func _ready() -> void:
	freeze = true
	
	#enabling a longer "hi-speed" collider for fast bullets. Because collision can get buggy and phase through targets if it's moving too fast (like scratch)
	#however, there is a "Cast Ray" option for the Rigidbody, which seems to do that already. Therefore, I'll disable this code for now. But if we have problems with Cast Ray then we can re-enable this
	$"hi-speeds".disabled = true
	#if hi_speed:
		#$"hi-speeds".disabled = false
	#else:
		#$"hi-speeds".disabled = true
func set_sprite(newsprite: Texture2D):
	$Sprite2D.texture = newsprite

func _physics_process(delta: float) -> void:
	look_at(linear_velocity+ global_position)


func _on_body_entered(body: Node) -> void:
	if body.has_method("damage"):
		body.damage(dmg)
	else:
		var new_dirt = dirt_effect.instantiate()
		new_dirt.position = Vector2.ZERO
		new_dirt.emitting = true
		add_child(new_dirt)
		new_dirt.reparent(get_tree().current_scene)
		new_dirt.rotation = 0
	
	queue_free()
