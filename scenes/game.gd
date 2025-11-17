extends Node

@onready var world_2d: Node2D = %World2D

var _camera:PackedScene = preload("uid://dgrbfm8uraqa1")

var _player:PackedScene = preload("uid://cm5xa8wyhrdn1")
var player:CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func create_player():
	if player != null:
		return
	else:
		var current_spawn = world_2d.get_child(0).spawn
		var new_player = _player.instantiate()
		world_2d.add_child(new_player)
		new_player.global_position = current_spawn.global_position
		new_camera_creation(new_player)
		

func new_camera_creation(player_in_cam:CharacterBody2D):
	var new_camera = _camera.instantiate()
	new_camera._player = player_in_cam
	world_2d.add_child(new_camera)
	CameraManager.current_camera = new_camera
