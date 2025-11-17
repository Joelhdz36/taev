extends CanvasLayer

@onready var options: CanvasLayer = %Options

#GUIDE Input
var pause_action:GUIDEAction = preload("uid://cn2pd0oga6t16")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if pause_action.is_triggered():
		_on_continue_btn_pressed()


func _on_option_btn_pressed() -> void:
	options.visible = true


func _on_continue_btn_pressed() -> void:
	get_tree().paused = !get_tree().paused
	queue_free()
