extends CanvasLayer

@onready var h_box_container: HBoxContainer = %HBoxContainer

@export var icons:Array[ColorRect] = []

var inventory_item_scene:PackedScene = preload("uid://c0cayd5fr4mjn")

#GUIDE
var inventory_action:GUIDEAction = preload("uid://cnp3rs8pb2o7a")

func _process(_delta: float) -> void:
	if inventory_action.is_triggered():
		get_tree().paused = !get_tree().paused
		queue_free()

func create_inventory():
	for item in InventoryManager.objects_in_inventory:
		create_item(item)


func create_item(item_to_create:Resource):
	var new_item = inventory_item_scene.instantiate()
	h_box_container.add_child(new_item)
	new_item.display_info(item_to_create)
