extends CollisionPolygon2D

@export var terrain_poly: Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if terrain_poly:
		polygon = terrain_poly.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
