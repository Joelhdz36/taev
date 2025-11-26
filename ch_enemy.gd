extends CharacterBody2D

@export var enemy_resource:Resource

var blood_particles_scene:PackedScene = preload("uid://btixd41gt8an5")

var _health:float
var _damage:float
var _wonder_speed:float

#Wonder variables
var wonder_max_pos:float
var wonder_min_pos:float
var dir:float = 1.0

#Follow variables
var player:CharacterBody2D
var origin_pos:float
var _follow_speed:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_initial_values()

func set_initial_values():
	_health = enemy_resource.health
	_damage = enemy_resource.damage
	_wonder_speed = enemy_resource.wonder_speed
	_follow_speed = enemy_resource.follow_speed
	
	origin_pos = global_position.x
	wonder_max_pos = global_position.x + 30
	wonder_min_pos = global_position.x - 30

func take_damage(damage:float,_player_pos:Vector2):
	var _dir:Vector2 = Vector2(_player_pos - global_position).normalized()
	var impulse = 90 * -_dir.x
	velocity.x = impulse
	$StateChart.send_event("toHurt")
	_health -= damage
	var dp = -((Vector2(1,0).dot(to_local(_player_pos).normalized())))
	var ndp:Vector2 = Vector2(dp,0).normalized()
	create_blood(ndp.x)
	die()
	move_and_slide()

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
		


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		$StateChart.send_event("toFollow")


func _on_wonder_state_physics_processing(delta: float) -> void:
	if global_position.x > wonder_max_pos or global_position.x < wonder_min_pos:
		dir *= -1.0
	velocity.x = (_wonder_speed * delta) * dir
	
	move_and_slide()

func _on_follow_state_physics_processing(delta: float) -> void:
	if player != null:
		velocity = Vector2.ZERO
		global_position.x = move_toward(global_position.x, player.global_position.x,50 * delta)

	move_and_slide()




func _on_origin_state_physics_processing(delta: float) -> void:
	global_position.x = move_toward(global_position.x,origin_pos,30.0 * delta)
	if global_position.x == origin_pos:
		$StateChart.send_event("toWonder")



func _on_hurt_state_physics_processing(delta: float) -> void:
	
	velocity.x = move_toward(velocity.x,0,350 * delta)
	if velocity.x == 0.0:
		$StateChart.send_event("toFollow")
	move_and_slide()
