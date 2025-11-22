class_name cameraManager
extends Node

var current_camera:Camera2D

func set_camera_limits(limits:Vector2):
	current_camera.limit_left = int(limits.x)
	current_camera.limit_right = int(limits.y)

func change_cam_resolution():
	current_camera.set_camera_values()
