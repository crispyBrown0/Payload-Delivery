extends Node2D

@onready var final_text = $"Control/final text"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	final_text.text = "[color=red][font_size=72]Thanks for playing Payload Delivery!\n\n[font_size=48]By khlob and crispyBrown\n\n\n[indent]Your stats:\n[indent]Levels Completed: "
	final_text.text += str(root.levels_completed) + "/7\nShots Fired: " +str(root.ammo)+"\nTargets Destroyed: "+str(root.total_kills)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
