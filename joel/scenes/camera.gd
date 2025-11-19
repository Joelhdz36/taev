extends Camera2D

var player_offset:Vector2

var screen_size:Vector2

var _player:CharacterBody2D
var damping_speed:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_camera_values()

#resore version
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if _player != null:
		if _player.velocity.x != 0.0:
			follow_player(delta)
		else:
			go_back_to_player(delta)

func set_camera_values():
	screen_size = get_viewport_rect().size
	#camera position and offset
	player_offset.y = roundi(screen_size.y * 0.085)
	player_offset.x = roundi(screen_size.x * 0.03)

	global_position.y = _player.global_position.y - player_offset.y
	global_position.x = _player.global_position.x
	
	#camera zoom
	var cam_zoom:Vector2 = Vector2((screen_size.y * 6)/1080,(screen_size.y * 6)/1080)
	zoom = cam_zoom

	

func follow_player(_delta:float):
	damping_speed += _delta * 0.15
	var _player_direction = _player.velocity.normalized()
	var camera_offset:Vector2 = Vector2(player_offset.x * _player_direction.x,-player_offset.y - roundi(player_offset.y * 0.35))
	global_position = lerp(global_position, _player.global_position + camera_offset, damping_speed)


func go_back_to_player(_delta:float):
	damping_speed = 0.0
	var camera_offset:Vector2 = Vector2(0,-player_offset.y)
	global_position = lerp(global_position, _player.global_position + camera_offset, .025)
