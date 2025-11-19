extends Node2D

@export var enemy_resource:Resource

var _health:float
var _damage:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_initial_values()
	print(_health,_damage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_initial_values():
	_health = enemy_resource.health
	_damage = enemy_resource.damage




func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(_damage)
