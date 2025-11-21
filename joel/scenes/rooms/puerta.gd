extends ColorRect

@export var next_scene:String
@export var in_front:bool

var can_actuate = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if in_front:
		z_index = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interaction():
	SceneManager.change_scene(next_scene)

func _on_door_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$InteractionIcon.show()
		body.current_obj = self
		body.can_interact = true


func _on_door_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$InteractionIcon.hide()
		body.current_obj = null
		body.can_interact = false
