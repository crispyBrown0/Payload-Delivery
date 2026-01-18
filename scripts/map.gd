extends TextureRect

@onready var poly = $Polygon2D

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func draw_map(polygon: Array[Vector2]):
	var new_map = []
	
	for looking in polygon:
		var addx = (looking.x + 1000 * 100) / 1000
		var addy = (looking.y + 2000 * 100) / 1000
		new_map.append(Vector2(addx, addy))
	
	poly.polygon = new_map
