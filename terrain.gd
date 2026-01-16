extends StaticBody2D

@onready var poly = $TerrainPoly
@onready var colli = $TerrainColli as CollisionPolygon2D
@onready var line = $TerrainLine
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	colli.polygon = poly.polygon
	line.points = poly.polygon


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
