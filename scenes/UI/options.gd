extends CanvasLayer

var game_resolutions:Array[Vector2] = [Vector2(1920,1080),Vector2(1240,720)]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_item_list_item_selected(index: int) -> void:
	DisplayServer.window_set_size(game_resolutions[index])
	var screen_size:Vector2 = DisplayServer.screen_get_size()
	var game_window:Vector2 = get_viewport().size

	var screen_position:Vector2
	screen_position = Vector2(screen_size.x/2 - game_window.x/2,screen_size.y/2 - game_window.y/2)
	DisplayServer.window_set_position(screen_position)
	CameraManager.change_cam_resolution()
	hide()
	#DisplayServer.window_set_size(game_resolutions[index])
	#var monitor:int = DisplayServer.window_get_current_screen()
	#var monitor_size = DisplayServer.window_get_size(monitor)
	#DisplayServer.window_set_position(Vector2(monitor_size.x/2,0.0))
	#CameraManager.change_cam_resolution()
