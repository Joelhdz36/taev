extends Node2D



@export var obj_resource:Resource

@export var animate_sprite:bool = true
@export var freq:float = 0.02
@export var angle:float = 15.0
var time:float

var pickable:bool = false
var dialogo:DialogicTimeline

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GPUParticles2D.emitting = animate_sprite
	if InventoryManager.check(obj_resource):
		queue_free()
	display_info()


func _process(delta: float) -> void:
	time += delta
	if animate_sprite:
		%Icon.global_position.y += sin(angle*time) * freq

func display_info():
	%Icon.texture = obj_resource.game_icon

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

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Personaje":
		body.can_interact = false
		body.current_obj = null
