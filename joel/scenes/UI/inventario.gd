extends CanvasLayer

@onready var image_visualizer: PanelContainer = %ImageVisualizer


@export var icons:Array[ColorRect] = []

var inventory_item_scene:PackedScene = preload("uid://c0cayd5fr4mjn")
var inventory_index:int = 0
#GUIDE
var inventory_action:GUIDEAction = preload("uid://cnp3rs8pb2o7a")



func _process(_delta: float) -> void:
	if inventory_action.is_triggered():
		get_tree().paused = !get_tree().paused
		queue_free()

func create_inventory():
	if InventoryManager.objects_in_inventory.size() > 0:
		create_item(InventoryManager.objects_in_inventory[inventory_index])
	else: return

func create_item(item_to_create:Resource):
	clear_visualizer()
	var new_item = inventory_item_scene.instantiate()
	image_visualizer.add_child(new_item)
	new_item.display_info(item_to_create)

func clear_visualizer():
	if image_visualizer.get_child_count() > 0:
		for child in image_visualizer.get_children():
			child.queue_free()



func _on_left_btn_pressed() -> void:
	if inventory_index > 0:
		inventory_index -= 1
	else:
		inventory_index = InventoryManager.objects_in_inventory.size() -1
	create_item(InventoryManager.objects_in_inventory[inventory_index])


func _on_right_btn_pressed() -> void:
	if inventory_index < InventoryManager.objects_in_inventory.size() -1:
		inventory_index += 1
	else:
		inventory_index = 0
	create_item(InventoryManager.objects_in_inventory[inventory_index])
