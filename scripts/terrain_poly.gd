extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_terrain()

func generate_terrain():
	var new_terrain = [Vector2(km(-1),m(500)), Vector2(km(10),m(500))]
	var scannerx = km(10)
	var scannery = m(100)
	while scannerx > m(300):
		new_terrain.append(Vector2(scannerx, scannery * (scannerx/km(10))))
		scannerx -= m(randi_range(50, 250))
		scannery += m(randi_range(-100, 100))
		if scannery > 250:
			scannery = 250 - m(randi_range(0, 100))
	while scannerx > m(30):
		new_terrain.append(Vector2(scannerx, scannery * (scannerx/km(10))))
		scannerx -= m(randi_range(5, 15))
		scannery += m(randi_range(-100, 100))
		if scannery > 250:
			scannery = 250 - m(randi_range(0, 100))
	new_terrain.append(Vector2(m(15), m(-1)))
	new_terrain.append(Vector2(0, 100))
	new_terrain.append(Vector2(km(-0.5), m(100)))
	
	polygon = new_terrain
	uv = new_terrain
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func km(how_far: float) -> float:
	return m(how_far) * 1000
func m(how_far: float) -> float:
	return how_far * 100
