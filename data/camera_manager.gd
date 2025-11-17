class_name cameraManager
extends Node

var current_camera:Camera2D

func change_cam_resolution():
	current_camera.set_camera_values()
