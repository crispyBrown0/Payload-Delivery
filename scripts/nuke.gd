extends Node2D

@onready var flashbang = $flashbang
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flashbang.modulate.a = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	flashbang.modulate.a -= delta /2
	timer += delta
	
	if timer > 5:
		get_tree().change_scene_to_file("res://SCENES/ending.tscn")
