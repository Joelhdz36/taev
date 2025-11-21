extends Node2D

@onready var interact_icon: Label = %InteractIcon

@export var obj_resource:Resource

var pickable:bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	display_info()


func display_info():
	$Background.color = obj_resource.color_test

func interaction():
	InventoryManager.add_to_inventory(obj_resource)
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Personaje":
		body.can_interact = true
		interact_icon.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Personaje":
		body.can_interact = false
		interact_icon.hide()
