extends RichTextLabel

var timer = 0
var quicker = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if !visible:
		return
	
	if timer > 3:
		modulate.a = 1 - (timer -3) / 3
	if timer >= 6:
		visible = false
		
	if quicker:
			modulate.a = 1 - (timer - 1)/1
			if timer > 2:
				visible = false

func reset():
	modulate.a = 1
	timer = 0
	visible = true
	quicker = true
