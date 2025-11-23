extends CharacterBody2D

@export var enemy_resource:Resource

var blood_particles_scene:PackedScene = preload("uid://btixd41gt8an5")

var _health:float
var _damage:float
var _wonder_speed:float

var wonder_max_pos:float
var wonder_min_pos:float
var dir:float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_initial_values()

func set_initial_values():
	_health = enemy_resource.health
	_damage = enemy_resource.damage
	_wonder_speed = enemy_resource.wonder_speed
	
	wonder_max_pos = global_position.x + 30
	wonder_min_pos = global_position.x - 30

func take_damage(damage:float,player_pos:Vector2):
	_health -= damage
	var dp = -((Vector2(1,0).dot(to_local(player_pos).normalized())))
	var ndp:Vector2 = Vector2(dp,0).normalized()
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
		DataManager.defeated_enemies.append(enemy_resource)
		queue_free()

func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(_damage,global_position)
		


func _on_wonder_state_physics_processing(delta: float) -> void:
	if global_position.x > wonder_max_pos or global_position.x < wonder_min_pos:
		dir *= -1.0
	velocity.x = (_wonder_speed * delta) * dir
	
	move_and_slide()
