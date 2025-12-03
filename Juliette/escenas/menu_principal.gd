extends Control


func _on_iniciar_pressed() -> void:
	SceneManager.cambio_escena("uid://dsiu560phtwcg")


func _on_ajustes_pressed() -> void:
	SceneManager.cambio_escena("uid://c4mqr7824uavn")


func _on_salir_pressed() -> void:
	get_tree().quit()
