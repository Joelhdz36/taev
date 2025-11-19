extends CharacterBody2D


@export var SPEED = 300.0

#GUIDE input
var player_context:GUIDEMappingContext = preload("uid://bcnkmasrse8hk")
var movement_action:GUIDEAction = preload("uid://cj1j03264ex7p")
var run_action:GUIDEAction = preload("uid://iydbahyoh7tg")

#Health
var player_health:float

func _ready() -> void:
	GUIDE.enable_mapping_context(player_context)
	player_health = HealthManager.health

func _physics_process(delta: float) -> void:
	var speed:float
	speed = SPEED
	
	if run_action.is_triggered():
		speed = SPEED * 2.5
	var direction := movement_action._value_axis_2d
	
	if direction:
		velocity.x = direction.x * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()


func take_damage(damage:float):
	player_health -= damage
	HealthManager.health = player_health
	die()

func die():
	if player_health > 0:
		return
	queue_free()
	get_parent().get_parent().create_player()
	
	
