extends Node2D
class_name root

@onready var range_guide_button = $"UI LAYER/Control/range guide"
@onready var wep = $PlayerBase/PlayerWeapon
@onready var enemy_spawner = $"enemy spawner"
@onready var shot_info = $"UI LAYER/Control/shot info"
@onready var level_slider = $"UI LAYER/Control/levelSlider"
@onready var level_label = $"UI LAYER/Control/levelLabel"

func _ready() -> void:
	$MAP/Terrain/TerrainPoly.generate_terrain()
	$MAP/Terrain.sync_colli_line()
	enemy_spawner.type = 0
	enemy_spawner.spawn_enemies()
	level_label.text = "(0/3) Level 1: Rubber Band"
	$"UI LAYER/Control/map".draw_map($MAP/Terrain/TerrainPoly.polygon)
	
	range_guide_button.visible=  false
	shot_info.visible = false



func _process(delta: float) -> void:
	#range_guide_button.visible = true
	if !range_guide_button.visible and wep.velocities[wep.WEAPON]>=5000:
		range_guide_button.visible = true
	if !shot_info.visible and wep.velocities[wep.WEAPON] >= 2000:
		shot_info.visible = true
	
	do_next_waves()

static func str_m_or_km(dist: float) -> String:
	if dist < 1000:
		return str(int(dist)) + " m"
	else:
		return str(int(dist/100)/10.0) + " km" #"rounded" to tenths

func do_next_waves():
	if enemy_spawner.kills >= 3:
		enemy_spawner.type += 1
		enemy_spawner.wipe_all()
		enemy_spawner.spawn_enemies()
		shot_info.last_known_bullet_x = 0
		wep.WEAPON += 1
		level_slider.level_up()
	else:
		level_slider.to_value = enemy_spawner.kills
		level_label.text = "("+str(enemy_spawner.kills)+"/3 Level "+str(enemy_spawner.type+1)+": "+wep.names[wep.WEAPON]
