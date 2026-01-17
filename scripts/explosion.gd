extends Node2D

var timer = 0

func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= 3.2:
		queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.visible = false
