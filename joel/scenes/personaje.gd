extends CharacterBody2D
@onready var state_chart: StateChart = %StateChart

@onready var looking_at: Area2D = %LookingAt
@onready var dmg_collider: CollisionPolygon2D = %DmgCollider

@export var SPEED = 300.0
var last_direction:float = 1.0
#GUIDE basic movement input
var player_context:GUIDEMappingContext = preload("uid://bcnkmasrse8hk")
var movement_action:GUIDEAction = preload("uid://cj1j03264ex7p")
var run_action:GUIDEAction = preload("uid://iydbahyoh7tg")

#GUIDE attack input
var player_attack_context:GUIDEMappingContext = preload("uid://cp8okplon72p5")
var attack_action:GUIDEAction = preload("uid://dvv5kqyv4tl8")

@export var damage:float = 5.0

var atk_timer:float = 0.2
var _atk_timer:float = 0.2
var attacking:bool = false
var atk_cooldown:float = 0.2
var _atk_cooldown:float = 0.2

#Health
var player_health:float

func _ready() -> void:
	GUIDE.enable_mapping_context(player_context)
	GUIDE.enable_mapping_context(player_attack_context)
	player_health = HealthManager.health

func _draw() -> void:
	var line_pivot = Vector2(0, -16)
	draw_line(line_pivot,(line_pivot + Vector2(64,0)),Color.RED,2.0,false)
	draw_line(line_pivot,to_local(get_global_mouse_position()),Color.YELLOW,1.0,false)

func _process(delta: float) -> void:
	if attack_action.is_triggered() and atk_timer <= 0.0:
		attacking = true
	else:
		atk_timer -= delta
	if attacking:
		attack(delta)
	queue_redraw()

#func _physics_process(delta: float) -> void:



func attack(_delta:float):
	dmg_collider.show()
	dmg_collider.disabled = false
	atk_cooldown -= _delta
	if atk_cooldown <= 0:
		atk_timer = _atk_timer
		atk_cooldown = _atk_cooldown
		dmg_collider.hide()
		attacking = false
		dmg_collider.disabled = true

func take_damage(received_damage:float,enemy_pos:Vector2):
	state_chart.send_event("toDamaged")
	#player_health -= received_damage
	#HealthManager.health = player_health
	die()

func die():
	if player_health > 0:
		return
	queue_free()
	get_parent().get_parent().create_player()




func _on_damage_area_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemigo"):
		area.get_parent().take_damage(damage)


func _on_idle_state_processing(_delta: float) -> void:
	if movement_action.is_triggered():
		state_chart.send_event("toWalk")


func _on_walking_state_physics_processing(delta: float) -> void:
	var speed:float
	speed = SPEED
	
	if run_action.is_triggered():
		speed = SPEED * 2.5
	var direction := movement_action._value_axis_2d
	
	if direction:
		
		velocity.x = direction.x * speed * delta
		if last_direction != direction.x:
			looking_at.position.x *= -1.0
			$DamageArea.scale.x *= -1.0
			last_direction = direction.x
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if velocity.x == 0:
			state_chart.send_event("toIdle")
	move_and_slide()

func _on_damaged_state_entered() -> void:
	var dir = movement_action.value_axis_2d.x
	var impulse:float = 450.0
	var dp = Vector2(dir,0).normalized().dot(get_global_mouse_position().normalized())
	var impulse_dir = Vector2(dp,0.0).normalized()  * -last_direction
	velocity.x = impulse * impulse_dir.x
	

func _on_damaged_state_physics_processing(delta: float) -> void:

	velocity.x = move_toward(velocity.x,0, 3800* delta)
	if velocity.x == 0:
		state_chart.send_event("toIdle")

	move_and_slide()
