class_name sceneManager
extends Node

var current_scene
var world_2d:Node2D
var spawn_pos:Vector2

func change_scene(uid:String):
	if current_scene != null:
		current_scene.queue_free()
	var new_scene_path = load(uid) as PackedScene
	var new_scene = new_scene_path.instantiate()
	world_2d.add_child(new_scene)
	#current_scene = new_scene
