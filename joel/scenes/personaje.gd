extends CharacterBody2D
@onready var state_chart: StateChart = %StateChart
@onready var anim_sprite: AnimatedSprite2D = %AnimSprite
@onready var player_sfx: AudioStreamPlayer2D = %PlayerSFX

@onready var looking_at: Area2D = %LookingAt
@onready var dmg_collider: CollisionPolygon2D = %DmgCollider

@export var step_sound:AudioStream

@export var SPEED = 300.0
@export var damage:float = 5.0

var last_direction:float = 1.0

#GUIDE basic movement input
var player_context:GUIDEMappingContext = preload("uid://bcnkmasrse8hk")
var movement_action:GUIDEAction = preload("uid://cj1j03264ex7p")
var run_action:GUIDEAction = preload("uid://iydbahyoh7tg")

#GUIDE attack input
var player_attack_context:GUIDEMappingContext = preload("uid://cp8okplon72p5")
var attack_action:GUIDEAction = preload("uid://dvv5kqyv4tl8")

var atk_timer:float = 0.2
var _atk_timer:float = 0.2
var attacking:bool = false
var atk_cooldown:float = 0.2
var _atk_cooldown:float = 0.2

#GUIDE interaction
var interaction:GUIDEAction = preload("uid://drombgc2fxd20")
var can_interact:bool = false
var current_obj

#Health
var player_health:float
var enemy_pos:Vector2

func _ready() -> void:
	GUIDE.enable_mapping_context(player_context)
	player_health = HealthManager.health


func _process(delta: float) -> void:
	if attack_action.is_triggered() and atk_timer <= 0.0:
		attacking = true
	else:
		atk_timer -= delta
	if attacking:
		attack(delta)
		
	if can_interact and interaction.is_triggered():
		current_obj.interaction()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()


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

func take_damage(received_damage:float, _enemy_pos:Vector2):
	enemy_pos = to_local(_enemy_pos).normalized()
	state_chart.send_event("toDamaged")
	player_health -= received_damage
	HealthManager.health = player_health
	die()
	

func die():
	if player_health > 0:
		return
	queue_free()
	get_parent().get_parent().create_player()




func _on_damage_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemigo"):
		area.get_parent().take_damage(damage,global_position)


func _on_idle_state_processing(_delta: float) -> void:
	if movement_action.is_triggered():
		state_chart.send_event("toWalk")


func _on_walking_state_physics_processing(delta: float) -> void:
	if anim_sprite.frame == 3:
		if !player_sfx.playing:
			player_sfx.play()
	var speed:float
	speed = SPEED
	
	if run_action.is_triggered():
		speed = SPEED * 1.45
	var direction := movement_action._value_axis_2d
	if direction:
		velocity.x = direction.x * speed * delta
		if last_direction != direction.x:
			looking_at.position.x *= -1.0
			$DamageArea.scale.x *= -1.0
			last_direction = direction.x
		if direction.x > 0:
			anim_sprite.flip_h = false
		else:
			anim_sprite.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if velocity.x == 0:
			state_chart.send_event("toIdle")
	move_and_slide()

func _on_damaged_state_entered() -> void:
	var dir = last_direction
	var impulse:float = 450
	var dp = Vector2(dir,0).normalized().dot(enemy_pos)
	var impulse_dir = Vector2(dp,0.0).normalized()  * -last_direction
	velocity.x = impulse * impulse_dir.x
	GUIDE.disable_mapping_context(player_context)

func _on_damaged_state_physics_processing(delta: float) -> void:
	velocity.x = move_toward(velocity.x,0, 3800* delta)
	if velocity.x == 0:
		state_chart.send_event("toIdle")
	move_and_slide()


func _on_damaged_state_exited() -> void:
	enemy_pos = Vector2.ZERO
	GUIDE.enable_mapping_context(player_context)

func disable_context():
	GUIDE.disable_mapping_context(player_context)

func enable_context():
	GUIDE.enable_mapping_context(player_context)
