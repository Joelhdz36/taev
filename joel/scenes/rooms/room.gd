extends Node2D

@onready var spawn: Node2D = %Spawn

@export var camera_limits:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_limits = CameraManager.set_camera_limits(camera_limits)
	SceneManager.current_scene = self
	SceneManager.spawn_pos = spawn.global_position
	$RoomName.text = name
	spawn_enemies()
	

func spawn_enemies():
	if DataManager.spawn_enemies:
		for enemy in $Enemigos.get_children():
			if DataManager.defeated_enemies.has(enemy.enemy_resource):
				enemy.queue_free()
	else:
		for enemy in $Enemigos.get_children():
			enemy.queue_free()
