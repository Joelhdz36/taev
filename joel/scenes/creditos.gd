extends Control

func _on_video_stream_player_finished() -> void:
	$AnimationPlayer.play("music_fade_out")
	await  $AnimationPlayer.animation_finished
	SceneManager.cambio_escena("uid://cyyolaqinmppd")
