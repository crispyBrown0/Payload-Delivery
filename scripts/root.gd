extends Node2D
class_name root

@onready var range_guide_button = $"UI LAYER/Control/range guide"
@onready var wep = $PlayerBase/PlayerWeapon
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MAP/Terrain/TerrainPoly.generate_terrain()
	$MAP/Terrain.sync_colli_line()
	$"enemy spawner".spawn_enemies()
	$"UI LAYER/Control/map".draw_map($MAP/Terrain/TerrainPoly.polygon)
	
	range_guide_button.visible=  false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !range_guide_button.visible and wep.velocities[wep.WEAPON]>=5000:
		range_guide_button.visible = true

static func str_m_or_km(dist: float) -> String:
	if dist < 1000:
		return str(int(dist)) + " m"
	else:
		return str(int(dist/100)/10.0) + " km" #"rounded" to tenths
