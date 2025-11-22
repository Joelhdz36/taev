extends ColorRect

@export var next_scene:String
@export var in_front:bool
@export var blocked:bool

var can_actuate = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !in_front:
		material = null
	$InteractionIcon.text = self.name
	if in_front:
		z_index = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if material != null:
		var local_player_pos = CameraManager.current_camera.to_local(CameraManager.current_camera._player.global_position)
		#var player_pos = CameraManager.cam_pos
		var screen_size = get_viewport().get_visible_rect().size
		var circle = (screen_size/2)  + local_player_pos
		get_material().set_shader_parameter("player_pos",local_player_pos)
		get_material().set_shader_parameter("circle",circle)
		


func interaction():
	if !blocked:
		SceneManager.change_scene(next_scene)
	else:
		print("puerta bloqueada")

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
