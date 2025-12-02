extends Sprite2D

@export var next_scene:String
@export var in_front:bool
@export var blocked:bool

@export var key_needed:Resource

var can_actuate = false

var door_player:CharacterBody2D 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if key_needed != null:
		blocked = !InventoryManager.check(key_needed)
		
	if !in_front:
		material = null
	if in_front:
		z_index = 5
		self_modulate = Color(0.498, 0.498, 0.498, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if material != null:
		var local_player_pos = CameraManager.current_camera.to_local(CameraManager.current_camera._player.global_position)
		#var player_pos = CameraManager.cam_pos
		var screen_size = get_viewport().get_visible_rect().size
		var circle = (screen_size/2)  + local_player_pos
		get_material().set_shader_parameter("player_pos",local_player_pos)
		get_material().set_shader_parameter("circle",circle)
		


func interaction():
	if key_needed != null:
		blocked = !InventoryManager.check(key_needed)
	if !blocked:
		$AudioStreamPlayer2D.play()
		var fade_out = preload("res://joel/scenes/juice/fade_in.tscn").instantiate()
		get_parent().add_child(fade_out)
		fade_out.fade_out()
		door_player.disable_context()
		await  $AudioStreamPlayer2D.finished
		door_player.global_position = global_position
		SceneManager.change_scene(next_scene)

func _on_door_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.current_obj = self
		body.can_interact = true
		door_player = body


func _on_door_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.current_obj = null
		body.can_interact = false
		door_player = null
