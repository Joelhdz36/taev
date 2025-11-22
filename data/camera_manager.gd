class_name cameraManager
extends Node

var current_camera:Camera2D

func set_camera_limits(limits:Vector2):
	var screen_size = get_viewport().get_visible_rect().size.x
	var cam_offset = ((screen_size/2)/current_camera.zoom.x)
	current_camera.limit_left = int(limits.x) + int(cam_offset)
	current_camera.limit_right = int(limits.y) - int(cam_offset)
	var new_limits = Vector2(current_camera.limit_left,current_camera.limit_right)
	return new_limits

func change_cam_resolution():
	current_camera.set_camera_values()
