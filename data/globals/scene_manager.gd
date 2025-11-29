class_name sceneManager
extends Node

var first_scene:PackedScene = preload("uid://dfsv0hngbrr2w")
var current_scene
var world_2d:Node2D
var spawn_pos:Vector2

func _ready():
	Dialogic.signal_event.connect(pause_game)
	Dialogic.timeline_ended.connect(pause_game.bind("pause_game"))

func change_scene(uid:String):
	if current_scene != null:
		current_scene.queue_free()
	var new_scene_path = load(uid) as PackedScene
	var new_scene = new_scene_path.instantiate()
	world_2d.add_child(new_scene)
	#current_scene = new_scene

func cambio_escena(uid:String):
	get_tree().call_deferred("change_scene_to_file", uid)

func create_fisrt_scene():
	var new_first_scene = first_scene.instantiate()
	world_2d.add_child(new_first_scene)


func pause_game(paused:String):
	if paused == "pause_game":
		get_tree().paused = !get_tree().paused
