extends RichTextLabel


var info_angle = 0
var tracking_bullet = null
var last_known_bullet_x = 0
var dist_tracked = 0

var enemy_x = 0

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	write_info()

func write_info():
	var print_angle = str(int(info_angle * -10)/10.0) + " degrees"
	var print_dist = "--- m"
	
	if tracking_bullet != null:
		dist_tracked = (tracking_bullet.global_position.x - global_position.x)/100.0
		last_known_bullet_x = tracking_bullet.position.x / 100.0
	
	if dist_tracked > 0:
		print_dist = dist_tracked
		print_dist = str_m_or_km(print_dist)
	
	var print_enemy_x = "NA"
	var print_enemy_diff = "--- m"
	if enemy_x > 0:
		enemy_x /= 100.0
		print_enemy_x = str_m_or_km(enemy_x)
		if last_known_bullet_x > 0:
			var delta_x = enemy_x - last_known_bullet_x
			if delta_x >= 0:
				print_enemy_diff = "+" + str_m_or_km(delta_x)
			else:
				print_enemy_diff = str_m_or_km(delta_x)
			
	
	
	
	text = print_angle + "\n" + print_dist + "\n\ntarget\n" + print_enemy_x +"\n" + print_enemy_diff


func str_m_or_km(dist: float) -> String:
	if dist < 1000:
		return str(int(dist)) + " m"
	else:
		return str(int(dist/100)/10.0) + " km" #"rounded" to tenths
