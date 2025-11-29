extends Node2D

@onready var interact_icon: Label = %InteractIcon

@export var obj_resource:Resource

var pickable:bool = false
var dialogo:DialogicTimeline

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if InventoryManager.check(obj_resource):
		queue_free()
	display_info()


func display_info():
	$Background.color = obj_resource.color_test

func interaction():
	if !obj_resource.dialogo == null:
		var dialogue:DialogicTimeline = obj_resource.dialogo
		Dialogic.process_mode = Node.PROCESS_MODE_ALWAYS
		Dialogic.start(dialogue).process_mode = Node.PROCESS_MODE_ALWAYS
		


	InventoryManager.add_to_inventory(obj_resource)
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Personaje":
		body.can_interact = true
		body.current_obj = self
		interact_icon.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Personaje":
		body.can_interact = false
		body.current_obj = null
		interact_icon.hide()
