extends Control


func _on_iniciar_pressed() -> void:
	SceneManager.cambio_escena("uid://d8siysa40v6k")


func _on_ajustes_pressed() -> void:
	var new_options_menu = preload("uid://wh1yt57sig52").instantiate()
	$Options.add_child(new_options_menu)
	
	#SceneManager.cambio_escena("uid://wh1yt57sig52")


func _on_salir_pressed() -> void:
	get_tree().quit()


func _on_creditos_pressed() -> void:
	SceneManager.cambio_escena("uid://bumpkbs527cjo")
