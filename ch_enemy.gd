extends CharacterBody2D

@export var enemy_resource:Resource

var blood_particles_scene:PackedScene = preload("uid://btixd41gt8an5")

var _health:float
var _damage:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_initial_values()
	print(_health,_damage)


func set_initial_values():
	_health = enemy_resource.health
	_damage = enemy_resource.damage

func take_damage(damage:float,player_pos:Vector2):
	_health -= damage
	var dp = -((Vector2(1,0).dot(to_local(player_pos).normalized())))
	var ndp:Vector2 = Vector2(dp,0).normalized()
	#print("dp: ", dp)
	print("pos: ", position)
	create_blood(ndp.x)
	die()

func create_blood(blod_dir:float):
	var new_blood = blood_particles_scene.instantiate() as GPUParticles2D
	get_parent().add_child(new_blood)
	new_blood.global_position = position
	new_blood.scale.x = blod_dir
	new_blood.emitting = true

func die():
	if _health <= 0:
		queue_free()

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(_damage,global_position)
		
