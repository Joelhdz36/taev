extends Node

@onready var world_2d: Node2D = %World2D
@onready var ui: Node = %UI

@export var _first_scene:PackedScene

#PauseMenu
var pause_menu_scene:PackedScene = preload("uid://dhfa6pg30wute")
var pause_menu:GUIDEAction = preload("uid://cn2pd0oga6t16")
var menus_context:GUIDEMappingContext = preload("uid://bas2hiqp4lqkd")

#Inventory
var inventory_scene:PackedScene = preload("res://joel/scenes/UI/inventario.tscn")
var inventory_menu:GUIDEAction = preload("uid://cnp3rs8pb2o7a")

#Player
var _camera:PackedScene = preload("uid://dgrbfm8uraqa1")
var _player:PackedScene = preload("uid://cm5xa8wyhrdn1")
var player:CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneManager.world_2d = $World2D/Rooms
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	GUIDE.enable_mapping_context(menus_context)
	create_player()
	SceneManager.create_fisrt_scene(_first_scene)
	player.global_position = SceneManager.spawn_pos
	CameraManager.current_camera.global_position = player.global_position 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if pause_menu.is_triggered():
		pause_game()
	elif inventory_menu.is_triggered():
		open_inventory()


func create_player():
	if player != null:
		return
	else:
		HealthManager.restore_full_health()

		var new_player = _player.instantiate()
		world_2d.call_deferred("add_child", new_player)
		new_player.global_position = SceneManager.spawn_pos
		player = new_player
		new_camera_creation(new_player)

func new_camera_creation(player_in_cam:CharacterBody2D):
	var new_camera
	if CameraManager.current_camera != null:
		CameraManager.current_camera.queue_free()
	new_camera = _camera.instantiate()
	new_camera._player = player_in_cam
	world_2d.add_child(new_camera)
	new_camera.global_position = new_camera._player.global_position
	CameraManager.current_camera = new_camera




func pause_game():
	var new_pause_scene = pause_menu_scene.instantiate()
	ui.add_child(new_pause_scene)
	get_tree().paused = !get_tree().paused


func open_inventory():
	var new_inventory = inventory_scene.instantiate()
	ui.add_child(new_inventory)
	new_inventory.create_inventory()
	get_tree().paused = !get_tree().paused

func respawn():
	player = null
	create_player()
	player.global_position = DataManager.last_player_pos
	SceneManager.change_scene(DataManager.last_player_scene)
