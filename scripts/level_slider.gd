extends HSlider


var to_value: float = 0
var leveling_up = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !leveling_up:
		value = lerpf(value, to_value, delta*3)
	else:
		if value < max_value:
			value += delta
		else:
			leveling_up = false
			value = 0
			modulate = Color.WHITE

func level_up():
	leveling_up = true
	modulate = Color.RED
