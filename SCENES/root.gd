extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MAP/Terrain/TerrainPoly.generate_terrain()
	$MAP/Terrain.sync_colli_line()
	$"enemy spawner".spawn_enemies()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
