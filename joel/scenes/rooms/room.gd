extends Node2D

@onready var spawn: Node2D = %Spawn

@export var camera_limits:Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera_limits = CameraManager.set_camera_limits(camera_limits)
	SceneManager.current_scene = self
	$RoomName.text = name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
