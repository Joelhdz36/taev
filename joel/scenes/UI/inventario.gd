extends CanvasLayer

@onready var image_visualizer: PanelContainer = %ImageVisualizer
@onready var key_visualizer: PanelContainer = %KeyVisualizer
@onready var notes_title: Label = %NotesTitle
@onready var key_title: Label = %KeyTitle
@onready var note_text: RichTextLabel = %NoteText
@onready var window_name: Label = %WindowName


@export var icons:Array[ColorRect] = []

@export var inventory_displayers:Array[VBoxContainer] = []

var inventory_item_scene:PackedScene = preload("uid://c0cayd5fr4mjn")
var item_index:int = 0
var key_index:int = 0
#GUIDE
var inventory_action:GUIDEAction = preload("uid://cnp3rs8pb2o7a")

var actual_item:Resource

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	notes_title.text = ""
	note_text.text = ""
	_on_notes_btn_pressed()

func _process(_delta: float) -> void:
	if inventory_action.is_triggered():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		get_tree().paused = !get_tree().paused
		queue_free()

func create_inventory():
	if InventoryManager.objects_in_inventory.size() > 0:
		create_item()
	else: return

func create_item():
	clear_visualizer(image_visualizer)
	if InventoryManager.objects_in_inventory.is_empty():
		return
	actual_item = InventoryManager.objects_in_inventory[item_index]
	var new_item = inventory_item_scene.instantiate()
	image_visualizer.add_child(new_item)
	new_item.display_info(actual_item)
	notes_title.text = actual_item.title
	show_item_info()

func create_key():
	clear_visualizer(key_visualizer)
	if InventoryManager.keys_in_inventory.is_empty():
		return
	actual_item = InventoryManager.keys_in_inventory[key_index]
	var new_item = inventory_item_scene.instantiate()
	key_visualizer.add_child(new_item)
	new_item.display_info(actual_item)
	key_title.text = actual_item.title
	show_item_info()

func clear_visualizer(obj_to_clean:PanelContainer):
	if obj_to_clean.get_child_count() > 0:
		for child in obj_to_clean.get_children():
			child.queue_free()


func show_item_info():
	note_text.text = actual_item.note_text

func clear_info():
	key_title.text = ""
	notes_title.text = ""
	note_text.text = ""
#update

func _on_notes_btn_pressed() -> void:
	window_name.text = "Notas"
	clear_info()
	for display in inventory_displayers:
		display.hide()

	inventory_displayers[0].show()
	create_item()


func _on_key_btn_pressed() -> void:
	window_name.text = "Objetos Clave"
	clear_info()
	for display in inventory_displayers:
		display.hide()
	inventory_displayers[1].show()
	create_key()


func _on_note_right_btn_pressed() -> void:
	if item_index < InventoryManager.objects_in_inventory.size() -1:
		item_index += 1
	else:
		item_index = 0
	
	create_item()


func _on_note_left_btn_pressed() -> void:
	if item_index > 0:
		item_index -= 1
	else:
		item_index = InventoryManager.objects_in_inventory.size() -1
	create_item()


func _on_key_left_btn_pressed() -> void:
	if key_index > 0:
		key_index -= 1
	else:
		key_index = InventoryManager.keys_in_inventory.size() -1
	create_key()


func _on_key_right_btn_pressed() -> void:
	
	if key_index < InventoryManager.keys_in_inventory.size() -1:
		key_index += 1
	else:
		key_index = 0
	
	create_key()
