extends CharacterBody2D

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

func _process(delta: float) -> void:
	if attack_action.is_triggered() and atk_timer <= 0.0:
		attacking = true
	else:
		atk_timer -= delta
	if attacking:
		attack(delta)
		

func _physics_process(delta: float) -> void:
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

func take_damage(received_damage:float):
	player_health -= received_damage
	HealthManager.health = player_health
	die()

func die():
	if player_health > 0:
		return
	queue_free()
	get_parent().get_parent().create_player()




func _on_damage_area_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemigo"):
		area.get_parent().take_damage(damage)
