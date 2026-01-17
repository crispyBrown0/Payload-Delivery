extends RigidBody2D
@export var projectile_velocity: float = 2000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
