extends CanvasLayer

@onready var h_box_container: HBoxContainer = %HBoxContainer

@export var icons:Array[ColorRect] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for rect in 4:
		var new_rect = ColorRect.new()
		h_box_container.add_child(new_rect)
		new_rect.color = Color.WHITE
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
