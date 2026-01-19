extends Node2D
class_name root

@onready var range_guide_button = $"UI LAYER/Control/range guide"
@onready var wep = $PlayerBase/PlayerWeapon
@onready var enemy_spawner = $"enemy spawner"
@onready var shot_info = $"UI LAYER/Control/shot info"
@onready var level_slider = $"UI LAYER/Control/levelSlider"
@onready var level_label = $"UI LAYER/Control/levelLabel"
@onready var ff_button = $"UI LAYER/Control/ff"
@onready var ammo_text = $"UI LAYER/Control/ammo"
@onready var message = $"UI LAYER/Control/tutorial"
@onready var powerup = $powerup
@onready var music = $MUSIC
var tracks: Array[AudioStream]
var playingi = 0

static var ammo = 0
static var total_kills = 0
static var levels_completed = 0

var debug_level = 0

func _ready() -> void:
	$MAP/Terrain/TerrainPoly.generate_terrain()
	$MAP/Terrain.sync_colli_line()
	enemy_spawner.type = 0
	enemy_spawner.spawn_enemies()
	level_label.text = "Level 1/8: Rubber Band"
	$"UI LAYER/Control/map".draw_map($MAP/Terrain/TerrainPoly.polygon)
	
	range_guide_button.visible=  false
	shot_info.visible = false
	ff_button.visible = false
	
	ammo = 0
	total_kills = 0
	levels_completed = 0
	
	tracks = [
		load("res://music/gameplay/Alt-Blossom_3 comp.mp3"),
		load("res://music/gameplay/DoTM unused comp.mp3"),
		load("res://music/gameplay/half-tracked comp.mp3"),
		load("res://music/gameplay/lenk64 otenbakoimusume_4 comp.mp3"),
		load("res://music/gameplay/tsunkaten game ver comp.mp3")
	]
	tracks.shuffle()
	music.stream = tracks[0]
	music.play()



func _process(delta: float) -> void:
	#range_guide_button.visible = true
	if !range_guide_button.visible and wep.velocities[wep.WEAPON]>=5000:
		range_guide_button.visible = true
	if !shot_info.visible and wep.velocities[wep.WEAPON] >= 2000:
		shot_info.visible = true
	if !ff_button.visible and wep.velocities[wep.WEAPON] >= 20000:
		ff_button.visible = true
	
	do_next_waves()
	#ammo_text.text = "Ammo: "+str(ammo)
	ammo_text.visible = false
	
	if ammo <= 3:
		ammo_text.modulate = Color.RED
	else:
		ammo_text.modulate = Color.WHITE

static func str_m_or_km(dist: float) -> String:
	if dist < 1000:
		return str(int(dist)) + " m"
	else:
		return str(int(dist/100)/10.0) + " km" #"rounded" to tenths

func do_next_waves():
	if enemy_spawner.type >= 7:
		return
	
	if enemy_spawner.kills >= 3 or enemy_spawner.type < debug_level:
		enemy_spawner.type += 1
		level_slider.level_up()
		enemy_spawner.wipe_all()
		message.text = "Level Up!"
		powerup.play()
		message.reset()
		wep.WEAPON += 1
		levels_completed += 1
		if enemy_spawner.type >= 7:
			level_label.text = "BALLISTIC MISSILE"
			return
		
		enemy_spawner.spawn_enemies()
		shot_info.last_known_bullet_x = 0
	else:
		level_slider.to_value = enemy_spawner.kills
		level_label.text = "Level "+str(enemy_spawner.type+1)+"/8: "+wep.names[wep.WEAPON]

func killd():
	total_kills += 1
	if enemy_spawner.kills < 3:
		message.text = "HIT!"
		message.reset()


func _on_music_finished() -> void:
	playingi += 1
	if playingi >= tracks.size():
		playingi = 0
	music.stream = tracks[playingi]
	music.play()
