extends Button
class_name BUTTONS

@export var type = 0
@export var settings: PackedScene
@export var game: PackedScene
@export var loading: Control
@export var guide: PackedScene

static var mouse_on_ui = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed", clicked)
	connect("mouse_entered", entered)
	connect("mouse_exited", exited)
	exited()

func entered():
	mouse_on_ui = true
func exited():
	mouse_on_ui = false


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
			get_parent().get_parent().queue_free()
		4:
			var new_guide = guide.instantiate()
			add_child(new_guide)
