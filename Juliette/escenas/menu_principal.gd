extends Control


func _on_iniciar_pressed() -> void:
	SceneManager.cambio_escena("uid://dsiu560phtwcg")


func _on_ajustes_pressed() -> void:
	SceneManager.cambio_escena("uid://wh1yt57sig52")


func _on_salir_pressed() -> void:
	get_tree().quit()
