extends Control

@onready var vol_main: Slider = $slider1
@onready var vol_sfx: Slider = $slider2
@onready var vol_music: Slider = $slider3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	
	var new_layer = CanvasLayer.new()
	get_tree().current_scene.add_child(new_layer)
	new_layer.layer = 3
	
	reparent(new_layer)
	
	
	#reparent(get_tree().current_scene)
	move_to_front()
	position = Vector2(0, 0)
	
	vol_main.value = AudioServer.get_bus_volume_linear(0)
	vol_sfx.value = AudioServer.get_bus_volume_linear(1)
	vol_music.value = AudioServer.get_bus_volume_linear(2)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().paused = false
		queue_free()

func changed(bus: int,amt: float):
	AudioServer.set_bus_volume_linear(bus, amt)


func _on_slider_1_value_changed(value: float) -> void:
	changed(0, value)


func _on_slider_2_value_changed(value: float) -> void:
	changed(1, value)


func _on_slider_3_value_changed(value: float) -> void:
	changed(2, value)
