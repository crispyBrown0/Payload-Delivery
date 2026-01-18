extends Node2D
class_name root


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MAP/Terrain/TerrainPoly.generate_terrain()
	$MAP/Terrain.sync_colli_line()
	$"enemy spawner".spawn_enemies()
	$"UI LAYER/Control/map".draw_map($MAP/Terrain/TerrainPoly.polygon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

static func str_m_or_km(dist: float) -> String:
	if dist < 1000:
		return str(int(dist)) + " m"
	else:
		return str(int(dist/100)/10.0) + " km" #"rounded" to tenths
