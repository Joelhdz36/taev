extends Node2D

@onready var interact_icon: Label = %InteractIcon

@export var obj_resource:Resource

var pickable:bool = false

##GUIDE
var pick_context:GUIDEMappingContext = preload("uid://clpchcj7mccuf")
var interaction:GUIDEAction = preload("uid://drombgc2fxd20")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GUIDE.enable_mapping_context(pick_context)
	display_info()

func _process(_delta: float) -> void:
	if pickable and interaction.is_triggered():
		pickup()

func display_info():
	$Background.color = obj_resource.color_test

func pickup():
	InventoryManager.add_to_inventory(obj_resource)
	print(InventoryManager.objects_in_inventory.size())
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Personaje":
		pickable = true
		interact_icon.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Personaje":
		pickable = false
		interact_icon.hide()
