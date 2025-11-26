extends CanvasLayer

var game_resolutions:Array[Vector2] = [Vector2(1920,1080),Vector2(1240,720)]

func _ready() -> void:
	%GeneralSound.value = AudioServer.get_bus_volume_db(0)
	%SFX.value = AudioServer.get_bus_volume_db(1)
	%Music.value = AudioServer.get_bus_volume_db(2)


func _on_resolution_size_item_selected(index: int) -> void:
	DisplayServer.window_set_size(game_resolutions[index])
	var screen_size:Vector2 = DisplayServer.screen_get_size()
	var game_window:Vector2 = get_viewport().size

	var screen_position:Vector2
	screen_position = Vector2(screen_size.x/2 - game_window.x/2,screen_size.y/2 - game_window.y/2)
	DisplayServer.window_set_position(screen_position)
	CameraManager.change_cam_resolution()
	hide()




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
	
