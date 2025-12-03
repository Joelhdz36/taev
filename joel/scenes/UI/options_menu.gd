extends CanvasLayer

var game_resolutions:Array[Vector2i] = [Vector2(1920,1080),Vector2(1240,720)]

func _ready() -> void:
	#%FullscreenBtn.toggle_mode = true
	%GeneralSound.value = AudioServer.get_bus_volume_db(0)
	%SFX.value = AudioServer.get_bus_volume_db(1)
	%Music.value = AudioServer.get_bus_volume_db(2)

	if DisplayServer.window_get_mode(0) == 3:
		_on_fullscreen_btn_toggled(true)

func _on_resolution_size_item_selected(index: int) -> void:
	DisplayServer.window_set_size(game_resolutions[index])
	var screen_size:Vector2 = DisplayServer.screen_get_size()
	var game_window:Vector2 = get_viewport().size

	var screen_position:Vector2
	screen_position = Vector2(screen_size.x/2 - game_window.x/2,screen_size.y/2 - game_window.y/2)
	DisplayServer.window_set_position(screen_position)
	#CameraManager.change_cam_resolution()
	#if DisplayServer.window_get_mode(0) == 3:
		#%FullscreenBtn.toggle_mode = true
	#else:
		#%FullscreenBtn.toggle_mode = false
#



func _on_general_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value)
	if value > %GeneralSound.min_value:
		AudioServer.set_bus_mute(0,false)
	else:
		AudioServer.set_bus_mute(0,true)

func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value)
	if value > %SFX.min_value:
		AudioServer.set_bus_mute(1,false)
	else:
		AudioServer.set_bus_mute(1,true)


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2,value)
	if value > %Music.min_value:
		AudioServer.set_bus_mute(2,false)
	else:
		AudioServer.set_bus_mute(2,true)
	


func _on_fullscreen_btn_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	#CameraManager.change_cam_resolution()
	var index: = game_resolutions.find(get_viewport().size)
	_on_resolution_size_item_selected(index)
