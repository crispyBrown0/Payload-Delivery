extends TextureRect

@onready var text = $"guide text"
var playerwep

func _ready() -> void:
	set_layer()
	set_text()
	
func set_layer():
	var new_layer = CanvasLayer.new()
	new_layer.layer = 2
	get_tree().current_scene.add_child(new_layer)
	
	reparent(new_layer)
	move_to_front()
	position = Vector2(1150,190)

func set_text():
	playerwep = get_tree().current_scene.get_node("PlayerWeapon")
	if playerwep==null:
		return
	
	var wepname = playerwep.names[playerwep.WEAPON]
	var vel = playerwep.velocities[playerwep.WEAPON]
	if playerwep.WEAPON == 8:
		vel = 100000
	
	text.text = "[font_size=64][center]\n" + str(wepname).to_upper() + "\n\n[font_size=32][left]\n[indent]"
	var angle = 10
	while angle <= 45:
		var xv = cos(deg_to_rad(angle)) * vel
		var yv = sin(deg_to_rad(angle)) * vel
		var time_to_vertex = yv / 980.0
		var total_dist = xv * time_to_vertex * 2
		total_dist = str_m_or_km(total_dist/100.0)
		
		text.text += str(angle) + " DEGREES.................................................." +total_dist + "\n\n"
		
		angle += 10
		if angle == 40:
			angle = 45
	
	text.text += "\n[/indent]\n[center]ESTIMATES FOR FLAT GROUND ONLY\nRESULTS NOT GUARANTEED"


func str_m_or_km(dist: float) -> String:
	if dist < 1000:
		return str(int(dist)) + " m"
	else:
		return str(int(dist/100)/10.0) + " km" #"rounded" to tenths
