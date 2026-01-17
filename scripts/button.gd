extends Button

@export var type = 0
@export var settings: PackedScene
@export var game: PackedScene
@export var loading: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed", clicked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	esc_settings()
	
func esc_settings():
	if type != 1:
		return
	if Input.is_action_just_pressed("escape"):
		clicked()

func clicked():
	match type:
		0:
			#get_tree().change_scene_to_file("res://root.tscn")
			loading.visible = true
			get_tree().change_scene_to_file(game.resource_path)
		1:
			var new_settings = settings.instantiate()
			add_child(new_settings)
		2:
			get_tree().quit()
		3:
			get_tree().paused = false
			get_parent().queue_free()
